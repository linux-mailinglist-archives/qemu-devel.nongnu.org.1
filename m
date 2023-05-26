Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B2712F08
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 23:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2fCE-00052K-Fb; Fri, 26 May 2023 17:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2fCD-00051s-5d
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2fCB-0003V0-EX
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685137318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RjoQitXWfwgiCkRxQ5+nXq1TiF/02FK3m7Vg6pes6s=;
 b=JJlwl6kX193Y2frW19dv5cj2RCsTpK45oPYDjYrYMzFzlp11RlXyDOSldlamJiI1eOgUm+
 pgfBNOYj9V2AHBD8mvM2aJB2UwklxPouEL3IiDV+BbbxPeXl8LkoIAudWk17W0HKfsYvBw
 pxg5NquCIjTlo5t3jeYrS7wewYYXGRk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-k9N54MfwN3y4LVzepfkoQA-1; Fri, 26 May 2023 17:41:56 -0400
X-MC-Unique: k9N54MfwN3y4LVzepfkoQA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f6b1853e80so2001371cf.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 14:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685137316; x=1687729316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RjoQitXWfwgiCkRxQ5+nXq1TiF/02FK3m7Vg6pes6s=;
 b=gQ8s8Xziw785m1yXuFngC2gxpC8YAUxoU7Rkk0ZxmH+pvgPdVrvNTJH4QZ2AOK8v2z
 7nzvfSUeyErxBpg2bNX7ns80JrzwHvxbCE0HPAqRySY4SmiPjoNBF88irB1/fQaAdvSp
 BIclJezBW49oPr0K9cDWOmadZDtZmHCS1+RnK0fSaDDNcNgwjrvMpYfCD2ldKuLy0ycp
 IK7za6LZ8+/NTQlPngNKY8LsQ+JEcLr1LrIV69UlH2Onk5dUKMZZBOhHlNeHx4ioXxEQ
 N6+H6/7e/FZAGJsVodW1kB3lTlbx9MWcE9Z3hJ41VvkOBAE1vbA8fZcVxENOnyOFUTFV
 pkzg==
X-Gm-Message-State: AC+VfDzYx9RUm9xflsnVOisWyYiTR4YfqPZp5HwtwdX8LAXPARdD7QIf
 NyMxM+4Ggc2G4gLZBb0ZwZAsAGUwo6lg54sIk9rdqGwpaC50T0woiMg0uGPDovHSoY+JiNSdtcH
 L3AsAj3BA6aWJ268=
X-Received: by 2002:ad4:5d46:0:b0:621:cef:f270 with SMTP id
 jk6-20020ad45d46000000b006210ceff270mr3303957qvb.5.1685137316013; 
 Fri, 26 May 2023 14:41:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nuPPtP1ZpLEkuPNvTC5Uga5BswdlPUfJTPQvJc1aglhO0jB/QpMNJD3SVVVfIsxZ6dzg00Q==
X-Received: by 2002:ad4:5d46:0:b0:621:cef:f270 with SMTP id
 jk6-20020ad45d46000000b006210ceff270mr3303942qvb.5.1685137315733; 
 Fri, 26 May 2023 14:41:55 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 n16-20020a0cbe90000000b0062168714c8fsm1492698qvi.120.2023.05.26.14.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 14:41:55 -0700 (PDT)
Date: Fri, 26 May 2023 17:41:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 00/10] migration: Remove QEMUFileHooks
Message-ID: <ZHEnorONziJksUaj@x1n>
References: <20230509120700.78359-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230509120700.78359-1-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, May 09, 2023 at 02:06:50PM +0200, Juan Quintela wrote:
> Hi
> 
> Changes in v3:
> - fix rdma_migration to reset clearly (thanks danp)
> - redo the cherks for migration/rdma
> - rebased on top of the counters series:
> [PATCH 00/21] Migration: More migration atomic counters
> Based-on: Message-Id: <20230508130909.65420-1-quintela@redhat.com>

Patch 9 should logically be split and spread into previous patches, but not
a big issue.

For the series:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


