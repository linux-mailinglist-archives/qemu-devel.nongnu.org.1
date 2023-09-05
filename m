Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 708997923CA
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:08:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXeX-0008Ha-BK; Tue, 05 Sep 2023 11:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdXdy-0007f8-9F
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdXdw-0008Fh-3a
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693926423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FC9vQE0oW7W1yRK6kJuNNJXQlhD1He9apVfJ2GTozK4=;
 b=XP308F66ndR145BK97BUsBlF6agnb9iwnvVMloiUcFUoCFJwbYrjyir4ZpsC6ua4y+vFLd
 d208zU4rgM2jXl2dt8X0yIAC/DUVaiEY21Pwh6JSoaqwvCLJ6g5+ywzQHKTeawrnxvog4M
 MrV8nAv9YlXXuKvAJBOCnDTXS1EOiLI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-Kbl_a3X4Meec4m9IWxU3KQ-1; Tue, 05 Sep 2023 11:07:01 -0400
X-MC-Unique: Kbl_a3X4Meec4m9IWxU3KQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65174aca002so4267126d6.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 08:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693926421; x=1694531221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FC9vQE0oW7W1yRK6kJuNNJXQlhD1He9apVfJ2GTozK4=;
 b=PMbJ3C0qeavTwH4YBSVWOiuhO4XJuXz7IjQxU+yHBEFych9o806x9QWCrDXC0XKf87
 LNJ1Bw1ZL6xMHDV15n2Th/cGnPCh6nEcO41wZ8SeT0CWdLz9emXIZbULi3QnZkq8l5wd
 qFKoYBJjg6i9VWngJxqyGYDOlSxGfcUkIG7W+PygpQWWyrP6FbHyhxhbL6g+Qyf9k+vg
 vcj9gCE4nmmXS+QY1KL7Uj+14/DnLrPcO5r49YIrz/q3vGFjNxrEL6b+MGuaMIUhyQMO
 S6xSGmUgu1SIWF8Z0FFypVG+ab1dDr6AjCZxGcC7unOvsOGhcIIZRm0GVlNl2HECwqeq
 FZFQ==
X-Gm-Message-State: AOJu0YxaFozctr3YclS53p64JgMahQ8m9G32O4GaeIqMny+pwuCpmYee
 jeQv0OJnoDDaGx3hFdF7IPd/sy2Mr/KKbXEc/WfaLunVFm5ov1/5M5fvIz8vuqIROFbibKz1Wy7
 pzI6wu+R0sBWI9xM=
X-Received: by 2002:a05:6214:f69:b0:63c:f852:aa3a with SMTP id
 iy9-20020a0562140f6900b0063cf852aa3amr15138210qvb.4.1693926421025; 
 Tue, 05 Sep 2023 08:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD50AtQr+37exzcmXqYqLHkDfR/UEDXLOjIFlzle1BKV2A7f/CVlamb3XlF36AKQlNuonB2A==
X-Received: by 2002:a05:6214:f69:b0:63c:f852:aa3a with SMTP id
 iy9-20020a0562140f6900b0063cf852aa3amr15138187qvb.4.1693926420790; 
 Tue, 05 Sep 2023 08:07:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d4-20020a0cdb04000000b0064f378f89a7sm4510453qvk.73.2023.09.05.08.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 08:07:00 -0700 (PDT)
Date: Tue, 5 Sep 2023 11:06:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com,
 leobras@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 1/2] vmstate: Mark VMStateInfo.get/put() coroutine_mixed_fn
Message-ID: <ZPdEEgi1NwBezlBB@x1n>
References: <20230905145002.46391-1-kwolf@redhat.com>
 <20230905145002.46391-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230905145002.46391-2-kwolf@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 05, 2023 at 04:50:01PM +0200, Kevin Wolf wrote:
> Migration code can run both in coroutine context (the usual case) and
> non-coroutine context (at least savevm/loadvm for snapshots). This also
> affects the VMState callbacks, and devices must consider this. Change
> the callback definition in VMStateInfo to be explicit about it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


