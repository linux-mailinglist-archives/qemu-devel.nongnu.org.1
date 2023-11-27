Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 167107FA3C2
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:56:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7d1J-0000Oq-V8; Mon, 27 Nov 2023 09:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7d18-0000O8-3z
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:55:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7d0t-0004er-9o
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701096906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udSUY48IvQvILKyl9WwLIkKKDKKOqw+qZT2zjccMxpk=;
 b=XYPSZeLHpg15GuzIHVzwpwEZZayvEltuSibWqN3con/MbylPgIszaKoWNd39mtKE9pXOfN
 qvcY06sg0xQrGxX4meiIzdOEZoKIHSHl0v2p2KuR61DejKimHgvpWu2E5TN73W8DEKpQqr
 eDTW918vDXkOF4LOmrWjFqdkNbh7Gl8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-z3zCm2EtPFGEjzkUpoxErQ-1; Mon, 27 Nov 2023 09:55:04 -0500
X-MC-Unique: z3zCm2EtPFGEjzkUpoxErQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67a05428cceso12853166d6.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 06:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701096904; x=1701701704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udSUY48IvQvILKyl9WwLIkKKDKKOqw+qZT2zjccMxpk=;
 b=DU3N82seF9Wk0dnRzqO3D/yGwCbfoEiKplAfMR8wgQ2vgj/6Fsw7tgslWB/+XxObPc
 0xebt7JT4t5HdLbMr30fdR4sMeMeLAHq372jGWChmJohOQUcjwjp0SNgUl+ubBJRpbgG
 ZzG5aceELu1XZdBJ0M/oZSvgkPhsxtCZy+dMy4oO2PohQTXwNMLSvbq6mUVwn9nVtIb/
 v9XC/PLYo1tkPay+pinRz/HX6Q+Wiqxcq+sR4ouL9lWV+cYhWrChl5N1ehwofawfxNd/
 ZR4UPIIkmjLXskPgLPojfAJGXz0AxJJIQj+ol0XF7Vh9SdmsaYKBeVjCTMk2Mz3lKuqx
 /zvg==
X-Gm-Message-State: AOJu0YxfT+pdRPUSwsFWHyMRUlJVIUfQn/af02E4g0seRGt3FniAgs5q
 KZllpnIkZck9omG9oIguELIEvL42OQTmWSXqpCz1pgT8o+Ivq+w2bBZR3Obzp8fDHePOj1vjBeb
 ZHLzZFcFUo5WiyDc=
X-Received: by 2002:ad4:4085:0:b0:67a:1673:fec4 with SMTP id
 l5-20020ad44085000000b0067a1673fec4mr11698514qvp.2.1701096904458; 
 Mon, 27 Nov 2023 06:55:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwD3MBaqI8yfJdExwALJkohc4SEwOHTTaILtk+d6xFWRQ5A8Ko2sk33ajTKQ86TAmETu0J/g==
X-Received: by 2002:ad4:4085:0:b0:67a:1673:fec4 with SMTP id
 l5-20020ad44085000000b0067a1673fec4mr11698493qvp.2.1701096904226; 
 Mon, 27 Nov 2023 06:55:04 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 e29-20020a0cb45d000000b0066cf4fa7b47sm2196565qvf.4.2023.11.27.06.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 06:55:03 -0800 (PST)
Date: Mon, 27 Nov 2023 09:55:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 7/7] tests/qtest/migration: Use the new
 migration_test_add
Message-ID: <ZWStxtvK4llLCfab@x1n>
References: <20231124161432.3515-1-farosas@suse.de>
 <20231124161432.3515-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124161432.3515-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Nov 24, 2023 at 01:14:32PM -0300, Fabiano Rosas wrote:
> Replace the tests registration with the new function that prints tests
> names.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


