Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF6775BB76
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 02:21:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMdrz-0000bh-Of; Thu, 20 Jul 2023 20:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qMdrv-0000bF-IO; Thu, 20 Jul 2023 20:19:39 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qMdrt-0002V4-8F; Thu, 20 Jul 2023 20:19:38 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-55fcc15e109so764923a12.3; 
 Thu, 20 Jul 2023 17:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689898774; x=1690503574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6nrQHcK99DVvCNeu+QSeo6IGGd6Eq7k8XS0v5MK3/A=;
 b=S98USWaOV69yvaRoD2uuc6eJXW/sbgPTZFsw4XzuZMZTeF9I9MqSeCxLC3+Gz0LZwK
 VjemCoE3R3gY8/SV6Obcf/4+fb2WzRdB/CtTxuXmo5TyyAUg4zT+Bdca75OJH1zwhEWC
 waxcjJuM6z3/nfq6LefObouoGTkq7l049e+f2nuDkaDoz5MwifObMKTE/GjeY/bGVrCO
 aHGewj6AXz3cwNMSFrYHJjJVzHsLn2iyObwoRV482Hz/W3ycWTGUw/QI8YTwNaSLidmP
 4TLtp+oo3+vmQTALAusTebMM6LYOj4zJGzoUyOH/xM0IGu9wAkza+f5FlMR7vZ6x0yUi
 rjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689898774; x=1690503574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m6nrQHcK99DVvCNeu+QSeo6IGGd6Eq7k8XS0v5MK3/A=;
 b=GA+OorQh9BsJ4i7j8VqQH4PTSxeBBfvMO5tf/z+Oss2U0AfAvkz2LY7wnhzTg+6/AV
 hPedeP+sPUahQdkY7y4QP5nh+o2S7Rvo2MvEYrsAHNk2qyAjOT51QJBafj+wnKqVWY1Q
 rJiGYINjDRY6GK9EB8k9fKtWjJ3WUzSTL9JI/bmo9zNVv9Yg/UPat1et6+nNrJzEjVtl
 bgmIdGFygqJKTe1mCQQ5/wKIsgSdXVReLzZ7ycVaihYTdS/Vfox8oOwajZMRFgaJQXdZ
 d8tZCv7SgJceM8QV6GdCrEISuAkKMeZ6WHnwht9hRqTjdq7C+zoes+xPDKccZChBRjW3
 XYRQ==
X-Gm-Message-State: ABy/qLa342/R3WMsoHxBhAEB3vY4DrXZAiTyQotxXMLcHF06wYPsAAds
 3PYngBrkJ2HGFj9BwzIklk0=
X-Google-Smtp-Source: APBJJlFf4tCE4lkXZwwqZuYVGNE8a8j858yKdVKumCwFtIawdejzQRgmuB0P87bZ4/sWgFaPZ6qqtQ==
X-Received: by 2002:a05:6a20:1613:b0:12d:e596:df21 with SMTP id
 l19-20020a056a20161300b0012de596df21mr518379pzj.7.1689898774300; 
 Thu, 20 Jul 2023 17:19:34 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a62fb07000000b006862af4914esm1784270pfm.145.2023.07.20.17.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 17:19:33 -0700 (PDT)
Message-ID: <ef53ae3a-86e3-439b-f2e5-ee0c28bccb91@gmail.com>
Date: Fri, 21 Jul 2023 09:19:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com
References: <cover.1689731819.git.jeuk20.kim@gmail.com>
 <20230720184919.GF210977@fedora>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20230720184919.GF210977@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/21/2023 3:49 AM, Stefan Hajnoczi wrote:
> Hi,
> I'm ready to merge this but encountered a bug when testing:
> 
>    $ qemu-system-x86_64 --device ufs --device ufs-lu
>    Segmentation fault (core dumped)
> 
> Please ensure there is an error message like with SCSI disks:
> 
>    $ qemu-system-x86_64 --device virtio-scsi-pci --device scsi-hd
>    qemu-system-x86_64: --device scsi-hd: drive property not set
> 
> Thanks,
> Stefan

Thanks for letting me know.
I'll fix it right away and send the patch again.

Thanks,
Jeuk

