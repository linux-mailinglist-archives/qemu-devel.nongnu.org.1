Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFAF70745A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 23:34:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzOlo-0003tK-79; Wed, 17 May 2023 17:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzOll-0003t1-PU
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzOlk-0002PW-0c
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684359190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yCMXFeI5aCvin78SFUUvbPKyYODaHY90bYpsrewDrR4=;
 b=AP/benz/zyI/NzMhZ3hrPRG20TKjZbSKEccrDZLF0juZpbp/kAQpulvSEZt3DX+/olZG9Y
 B53Yd+VihbPB/85NLH0XOMQ+Ie+f9R7p4MfIaipjS9PPmuC9ga5PhS8TLCyDDjwaXfNECA
 2J+DR2AA3vaA10vkA8ASDxLE0EJrFeA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-zwbWBfSjMcWfq_9l7JUDZg-1; Wed, 17 May 2023 17:33:09 -0400
X-MC-Unique: zwbWBfSjMcWfq_9l7JUDZg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-24e147c206eso833594a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 14:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684359188; x=1686951188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCMXFeI5aCvin78SFUUvbPKyYODaHY90bYpsrewDrR4=;
 b=Qd8dI3QaDh5kCsNL4FnM2G736NcSPY6jFEvuqkXveyysGD50g8pJ8cM8qRVhiJZ2Cc
 In37ZIsSgZqtBd7RejZNJS77crR7VO89clYFXElhhavnvU5staA8Lyy7wGm9II6qHeL8
 QmBAfBDMjzcAGKBhCvZiPHsd+xxaw+bxmX6ExrHpawrwbl7WVlD2r3vZsl+Kmj/Bghlj
 rAf6VntsSZF2duGGzE1tp9uWqt4YAs2O6qDuLPxrwBFhFPS3pRdXr0fPdKh2CuS41cIe
 URdl5Y5y8RFk4o+c1jBXf9PDaNyLKWD0h7zzTZXRiiFVkaDQNXr5SttQSHD4B/JJdDGj
 wqUw==
X-Gm-Message-State: AC+VfDw5Axtdsk5YVPVElksM4W53QE9vwTmpBfba6871e8P1IlUzIm/L
 JHGzFskn812D+K8blkCCw5ZBFCoWmDmaPs9S63xFYupKuYNWTAM3PC+9ovINddFa3pB6QUr4xZ1
 5gDuOdqhJwtzeEWE0T+kh6CFbZbqYevw=
X-Received: by 2002:a17:90a:1b0c:b0:253:2a56:3831 with SMTP id
 q12-20020a17090a1b0c00b002532a563831mr250485pjq.34.1684359188167; 
 Wed, 17 May 2023 14:33:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46StApNgwfc8T4kqJsfCY9/5EtDyMmH/aNQcjODqIeFLaRiGv7T8jEOf++g0jJEsl1oIdy0stGlJxhUhWXg1k=
X-Received: by 2002:a17:90a:1b0c:b0:253:2a56:3831 with SMTP id
 q12-20020a17090a1b0c00b002532a563831mr250472pjq.34.1684359187909; Wed, 17 May
 2023 14:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230416222838.36642-1-mateusz.p.albecki@gmail.com>
 <20230416222838.36642-2-mateusz.p.albecki@gmail.com>
In-Reply-To: <20230416222838.36642-2-mateusz.p.albecki@gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 May 2023 17:32:56 -0400
Message-ID: <CAFn=p-bcAW9aMymmWeVSMeyuT88YDZ2iYVh-t1GoogbBBPFjSw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/ide/core.c: fix handling of unsupported commands
To: Mateusz Albecki <mateusz.p.albecki@gmail.com>
Cc: qemu-devel@nongnu.org, Mateusz Albecki <mateusz.albecki@outlook.com>, 
 Niklas Cassel <niklas.cassel@wdc.com>, Niklas Cassel <nks@flawful.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Sun, Apr 16, 2023 at 6:29=E2=80=AFPM Mateusz Albecki
<mateusz.p.albecki@gmail.com> wrote:
>
> From: Mateusz Albecki <mateusz.albecki@outlook.com>
>
> Current code will not call ide_cmd_done when aborting the unsupported
> command which will lead to the command timeout on the driver side instead
> of getting a D2H FIS with ABRT indication. This can lead to problems on t=
he
> driver side as the spec mandates that device should return a D2H FIS with
> ABRT bit set in ERR register(from SATA 3.1 section 16.3.3.8.6)
>
> Signed-off-by: Mateusz Albecki <mateusz.p.albecki@gmail.com>
> ---
>  hw/ide/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 45d14a25e9..d7027bbd4d 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -2146,6 +2146,7 @@ void ide_bus_exec_cmd(IDEBus *bus, uint32_t val)
>
>      if (!ide_cmd_permitted(s, val)) {
>          ide_abort_command(s);
> +        ide_cmd_done(s);
>          ide_bus_set_irq(s->bus);
>          return;
>      }
> --
> 2.40.0
>

I recently noticed that Niklas Cassel sent a patch to fix unsupported
command handling:
https://lists.gnu.org/archive/html/qemu-devel/2023-04/msg05552.html

I suspect that his approach is the more technically correct one and
that calling ide_cmd_done here is a heavy cudgel that may have
unintended consequences. Am I mistaken?
Can you check that Niklas's patch solves your issue? I think you're
both solving the same problem. I've CC'd him on this patch as well.

--js


