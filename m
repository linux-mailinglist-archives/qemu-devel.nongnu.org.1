Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C31712EC0
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 23:11:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2eiU-00023f-8J; Fri, 26 May 2023 17:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2eiS-00023Q-RT
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2eiP-0004eq-RR
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685135460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PNs16xgE50VzaP8rGpZcl6x9lb1ThBDmaaqvGyBBfSU=;
 b=gAtEiH9buT8XHCyGcaAtQ9hNidMPFEflM1NY9ozJ1y7qie/KBSr6V8okZLM3wSYmBJZbwH
 LVqgIcriYmy2M5r02yfIFxBuLzBgMBFV0a/0GjWMuSN7WKwi1KKlSviui4qgYA2uykIJUx
 PaFF+BFwSNjDcjbeC2NJVxHde3awfHs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-WUrLHRphM-es_Y6_df-zPQ-1; Fri, 26 May 2023 17:10:19 -0400
X-MC-Unique: WUrLHRphM-es_Y6_df-zPQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-624a29df9feso2759886d6.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 14:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685135410; x=1687727410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNs16xgE50VzaP8rGpZcl6x9lb1ThBDmaaqvGyBBfSU=;
 b=UzrayR1oTlAC940rXKjhRY1f0AuRaBo+p9NoK6YCYoZCNXmqxC1DuDyQRWJatFJLFV
 UFbPcYGlo6Jwc9cZo7lgkYPZp6O6uw+reLmQLB5IaFvuf1IlfUvgdrQZODw3lqzIEjx8
 IsEbluQS2cfqO1g1srq7cvHE9C8wcmJLuKrjEK0jao6yCTat6f9mI3D68RzVTkc3NjY5
 NgWPsFwhhovaFALzixJvCUEAihUhH/nctmZFf5Adp9KvrLLjZSOsxRJBF0PzweEm/6CW
 0W64+joUPFV/eMrD3f5/xp0ODPkQd2WUViMWIpts/l4XBn2KwUZekOLbXovXEDZUGy/g
 FQ+Q==
X-Gm-Message-State: AC+VfDx9XHpkcGWoJxLnmoOulkfDdP6VobeTTO5fOfb+R1c+1yu642Nu
 M0GXq4kta9rn+SAjf7zDVMNhWvU54WCmN7djcrgH3elhphF+/fYrP74idBFJxh2Yl7yF1e2uzKW
 jArPmIVIG+6P6CV0=
X-Received: by 2002:a05:6214:4107:b0:532:141d:3750 with SMTP id
 kc7-20020a056214410700b00532141d3750mr3116425qvb.2.1685135410315; 
 Fri, 26 May 2023 14:10:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5c1rnw/hubJzblRHFfM29rHV8W/yqPHSslW6rX7tDv8jhB/b7pX7JJIqyGctyuEkIxd6jNEA==
X-Received: by 2002:a05:6214:4107:b0:532:141d:3750 with SMTP id
 kc7-20020a056214410700b00532141d3750mr3116413qvb.2.1685135410125; 
 Fri, 26 May 2023 14:10:10 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 mg16-20020a056214561000b0061b63237be3sm1478687qvb.131.2023.05.26.14.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 14:10:09 -0700 (PDT)
Date: Fri, 26 May 2023 17:10:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/5] migration/rdma: simplify ram_control_load_hook()
Message-ID: <ZHEgMNuyYuPu0DlL@x1n>
References: <20230504114443.23891-1-quintela@redhat.com>
 <20230504114443.23891-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504114443.23891-3-quintela@redhat.com>
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

On Thu, May 04, 2023 at 01:44:40PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


