Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C4F7E2000
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:29:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxdL-0008Nu-Ho; Mon, 06 Nov 2023 06:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qzxdJ-0008EN-1t
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qzxdH-0007p5-GY
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699269542;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MgNodTOahzIbLHS8ATQjfprZqF9ZhzoJjeBg5XvzFPk=;
 b=Ax4ewavqzdi9aD4FspcYbt889D46x9E3tYlTLa3Z5aHHl8canOhEWhgFndH9zje5PqAone
 sNvKNExtWZhqI0pev4DxnwBMMkTQiTNjSvL/L0BSXFoU6Qm0RGoQeM4D2FWm4BVY4HXTyA
 A+syk0V4MjqwqXNBcL06R7SjiWq0XzY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-SQiaKWRQMl22WFovgsuqIA-1; Mon, 06 Nov 2023 06:18:51 -0500
X-MC-Unique: SQiaKWRQMl22WFovgsuqIA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32db6a28e24so2039133f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269530; x=1699874330;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgNodTOahzIbLHS8ATQjfprZqF9ZhzoJjeBg5XvzFPk=;
 b=WsM/i/0tLuVkMOZUaEj7rSfsVyNIFW0XjWSART3fDzIW/3DuQw8W41e6gDg2raLfnd
 azTZZCn+XKqlJNfWrCJW0wX1RogthZ08RTcu4dozJlAvh/7rUjGz5YBZJSO9jDos9fQi
 1L5ZAafBwGyzc8gKqlEnD+ohEvyolyipF7eFPeRbkjedNNLPOrsS5SLvWMKWGDFafJUA
 UqDJbHm+YMUSg09RFC3qDvGnP6OzJeoF8zy4fXpqYaVq+4Lb+6Ar6hrSuSPTofqM6Mki
 gVc5Z/jWq053HrgVUAHppM7JvJmR2y6p5wl3IodQoSU/GRxqzUCTsdQGPAtYrgpnGpfi
 3vfg==
X-Gm-Message-State: AOJu0Yx2ahe8LPffm0c9SRCgqq8qjNyK9992viMWqQCAufmTnUgSlpmV
 la9xdoEXQTgEbJ44/9xe7EX4zB1StrsFrsMqcuZwvjk2acAsmqynrw5hWIOlwS0NU5eENAP81PV
 BHnKMYIwlwIK6Ke0=
X-Received: by 2002:a5d:414a:0:b0:32d:af58:b4e9 with SMTP id
 c10-20020a5d414a000000b0032daf58b4e9mr20199483wrq.24.1699269530187; 
 Mon, 06 Nov 2023 03:18:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvoxe2wMewy4cBeLs+e229dyAIPKtacegbHWd5XWwI9kdGiziF7G8ZN0cnAfZloJAtg8AY4g==
X-Received: by 2002:a5d:414a:0:b0:32d:af58:b4e9 with SMTP id
 c10-20020a5d414a000000b0032daf58b4e9mr20199470wrq.24.1699269529897; 
 Mon, 06 Nov 2023 03:18:49 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 dd23-20020a0560001e9700b0032f7f4d008dsm9250792wrb.20.2023.11.06.03.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:18:49 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 leobras@redhat.com
Subject: Re: [PATCH 66/71] migration: Constify VMState
In-Reply-To: <20231106065827.543129-67-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 5 Nov 2023 22:58:22 -0800")
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-67-richard.henderson@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 06 Nov 2023 12:18:48 +0100
Message-ID: <87cywn165j.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> ---
>  migration/global_state.c |  2 +-
>  migration/savevm.c       | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 4e2a9d8ec0..8ee15dbb06 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -131,7 +131,7 @@ static const VMStateDescription vmstate_globalstate = {
>      .post_load = global_state_post_load,
>      .pre_save = global_state_pre_save,
>      .needed = global_state_needed,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {

I would really like to have an initializer that is nicer than this.

The only thing that I have come up with is declaring it as its own variable,
but that that is ugly for other reasons.

Later, Juan.


