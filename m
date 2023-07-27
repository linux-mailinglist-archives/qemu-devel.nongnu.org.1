Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAFE765769
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:24:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2ia-0006iU-Pv; Thu, 27 Jul 2023 11:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP2iX-0006gX-Gr
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:15:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP2iU-00043x-5x
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:15:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc1218262so11683345e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690470948; x=1691075748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T9paCrhRkfuYGrx8nfs7VDORDaJUpxvITyQtyxUXUYc=;
 b=XSfMVdtceMRXW0jttsOm84xhZOEDU2Pp6giIi2Ri4NdvEmXx64Y9CMPLDLwNJMyHvL
 RujZeQXg6TKmnkK95Vg1gc4s9QcuB7YR59ZID+/Yzk9cjFRMFWR0UT12gnM/lcmRwjaJ
 XJrAyaw6FQRmbnkxtUQkUArKTmUjiI5EsDQAa0z1Ml5NQX6YztW2v3At9wXiG2s/STju
 jdClNj3Lu8qWoHnwGhprpHQZkHfrYLea6vPY2OpNtW1ZRLdikSX3f89JGNKDpjkindwC
 CFYstIZ98vXjRiQWIMnklXg2usj1pdGbUV0k4dKeV4ccNBVujZeHM0J35KQQtVOVebAh
 5oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690470948; x=1691075748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T9paCrhRkfuYGrx8nfs7VDORDaJUpxvITyQtyxUXUYc=;
 b=kpD4LQ6eUN3xKJ1qWw5OlbSU9MXjjYJH3iSxRmTbEXUYAc4FeqY3sOdpU5tzoIMAc1
 9DJQ3AMkfvpM3orUt7nThp/X2jeIiQGRHKO/driDc4hU6LeAZKtN8uoRa83++x/turEj
 G6iL/REO6es3vRzcSM3hR570w4Q5Mcubs7kImRvT3sdQHqaGLrnazQf+5DajEQ0MnCju
 +vA1N9359cpyjKXqA2/7WfCOg2DKqn55r9gKQwJEI/TyJKXtXu+AhjVRIIoQh+hb3QBB
 +P+mHPX71Bi7JIDIfXkhkzjwBiOEPwga7hGjEaU3KpHJioepdYXR4I3BkxERPZf/l2SI
 QYXQ==
X-Gm-Message-State: ABy/qLatZpdlmbagbsHx9JDRRsM3TSfEfzOo0EQEn5b8RQZGTsY2/Vq4
 bfdVRdOnzKShsJXw7RrXbAXVP0dpjVgA/yuuAbNbNrjNwLeDJigh
X-Google-Smtp-Source: APBJJlFoZ1ZX2kX5Sufz1aTLx2isIBW/NLmCAKhlWntM3vKoESRyiD4H2ZnJHJh8aJVT0a3BdESCz36Zq9D3nliQQro=
X-Received: by 2002:a05:600c:202:b0:3fc:9f:e75c with SMTP id
 2-20020a05600c020200b003fc009fe75cmr1938303wmi.11.1690470948463; Thu, 27 Jul
 2023 08:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230727150705.2664464-1-peter.maydell@linaro.org>
In-Reply-To: <20230727150705.2664464-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 16:15:37 +0100
Message-ID: <CAFEAcA-0prmwQ+En=oZnR=AH_v9DBUU=C7qjK+z436WDygBnhA@mail.gmail.com>
Subject: Re: [PATCH] block/iscsi: Document why we use raw malloc()
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 27 Jul 2023 at 16:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In block/iscsi.c we use a raw malloc() call, which is unusual
> given the project standard is to use the glib memory allocation
> functions. Document why we do so, to avoid it being converted
> to g_malloc() by mistake.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> There aren't many uses of raw malloc() in the codebase
> other than third-party library sourcecode. Mostly we have
> a comment noting when we're doing it deliberately.
> ---
>  block/iscsi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 34f97ab6460..5640c8b5657 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1058,6 +1058,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
>          return NULL;
>      }
>
> +    /* Must use malloc(): this is freed via scsi_free_scsi_task() */
>      acb->task = malloc(sizeof(struct scsi_task));
>      if (acb->task == NULL) {
>          error_report("iSCSI: Failed to allocate task for scsi command. %s",

The other option here would be to use scsi_create_task(),
if we're OK with requiring libiscsi 1.13 or better (that's
9 years old at this point, so should be OK...)

thanks
-- PMM

