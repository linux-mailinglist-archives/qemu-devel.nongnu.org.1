Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F96B74A4C3
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVPv-0001iV-1S; Thu, 06 Jul 2023 16:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHVPt-0001iI-9J
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHVPr-0000fd-PY
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688674646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Mo2Le56fBq6TN6Z1AjKJb7oo7BY2b2lUaI+zFkB5dA=;
 b=hDCykCYb8/kIIE4QJeoK/+1mTLhrmChdR+NlZjo9jWZh0G+cRvd0TSlro+nMHBK1COBTfb
 eMeccrd/h7MyyA9Dj6ymKvVfhxxeSlZlN0efNMcgZLgj2H4G3FLoMw2OULNNRhATXfNYdN
 9A7A7GBdVWdj5oKi4xXxxN7z/WHYHzg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-xm3SbR0XPBmcRyT95wflQQ-1; Thu, 06 Jul 2023 16:17:25 -0400
X-MC-Unique: xm3SbR0XPBmcRyT95wflQQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7673887b2cfso29386485a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 13:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688674644; x=1691266644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Mo2Le56fBq6TN6Z1AjKJb7oo7BY2b2lUaI+zFkB5dA=;
 b=kfVKdLwWPLAoKUrvIxVmptvh7OKP4/XC1AWSM9IipycRSPF782IB6b5SC3LToYSfX/
 M3bC/ATKE1y/SWXe+HxYXlOvql6Lyj4r1ni2HpUtxDEJXzwjnMoG3/Vyb/sYp8f6yQzQ
 oZNtKCykPmYk00lHX0ymEKaSk5dLQiliOT564hy0MVvxjuoejWkbjf6SehwnYUMlZ6l2
 kD+1OiocVzYvf5vDFBpQ7eZtsQt4iFvsQKCoWq9gnQjAAdGuvERAFn7nu/osdD/lRxbS
 adbR53H1qrglBBLuT/RcEGxKsMEnMpwQe2pUUm9+cl4dRMl8HCKOMh8zsw6fy8EXkABK
 BdrQ==
X-Gm-Message-State: ABy/qLahednd4sRymnjjjnpGS4wml6LTfuUdJpHo5VD9xxQDor0a7mIg
 x5I2KThw+JVXOabkAZ4aBRCgirRi0LobifZEWbCxZUHExe5hXHwt4JLjyDKQTqaVGc6evjk5vfS
 W4CLpUiPWc1wY2Jo=
X-Received: by 2002:a05:620a:19a7:b0:765:5b3d:8195 with SMTP id
 bm39-20020a05620a19a700b007655b3d8195mr3244125qkb.6.1688674644563; 
 Thu, 06 Jul 2023 13:17:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE/C8UX7SUddKeeHwddf6sLGXIl181RdfbTgRUQaemLfG1yt9uhHX3x8X7K4QCRIlIujm64rA==
X-Received: by 2002:a05:620a:19a7:b0:765:5b3d:8195 with SMTP id
 bm39-20020a05620a19a700b007655b3d8195mr3244109qkb.6.1688674644291; 
 Thu, 06 Jul 2023 13:17:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o20-20020a05620a131400b007673774caabsm1079256qkj.92.2023.07.06.13.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 13:17:24 -0700 (PDT)
Date: Thu, 6 Jul 2023 16:17:20 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Leonardo Bras Soares Passos <leobras@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
Message-ID: <ZKchUNPG1mofzSOC@x1n>
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
 <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
 <ZKcEjfTDDgDZWu9Q@x1n>
 <20230706144844-mutt-send-email-mst@kernel.org>
 <ZKcPr3gueuOM4LGY@x1n>
 <20230706155936-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706155936-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jul 06, 2023 at 04:00:49PM -0400, Michael S. Tsirkin wrote:
> I mean his patch is exactly right. cmask was designed with this
> kind of use case in mind.
> Will queue.

That's great news.

> If you want to suggest more text to the commit log, for the benefit
> of backporters, that is fine by me.

If you're fine with it I've no issue; since we're reaching soft-freeze I'd
think it better if it can be merged on time (or just slightly enhance the
commit message when merge).

Thanks!

-- 
Peter Xu


