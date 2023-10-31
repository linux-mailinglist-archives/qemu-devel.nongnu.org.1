Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 164C37DCF4A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:34:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpp8-0001o7-FI; Tue, 31 Oct 2023 10:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxpp6-0001nv-SY
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxpp5-0000AN-Fn
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698762866;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=99YnPeqUFWmDCKrHA0v4EhOWt1wtzjFqD698D/onj5Q=;
 b=JZmBulnQfO2r6Pv/Na1xRTTMIh/9sUD6An9pZLm407Yzl1/TsLODJO2EBXAjr0ltyM6uGW
 8UeX4TdWSQIexcHCS1y5MmB8AGJCZCRff/adlJ+ejQYh6pWIT9WHrlxu9KqSlNf989KyB1
 /DtHr+4q3eFZq4Y7pWI6/W7rqyYEAt4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-wMXf_ZbfN060IJT2AJRClQ-1; Tue, 31 Oct 2023 10:34:11 -0400
X-MC-Unique: wMXf_ZbfN060IJT2AJRClQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c563a2a4f0so62752511fa.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762850; x=1699367650;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99YnPeqUFWmDCKrHA0v4EhOWt1wtzjFqD698D/onj5Q=;
 b=dFu1qdSPY70nrkZiAJwgi/YUPpVWqC22R4Eghkdnn6w2iL+4epeWy+4gajQlG6ZMCV
 K7kO+BJfzCY42iZQ9IuEKs6tQjxY+Vp4uSD5kSS5AMCaZLMfZnGom1WZCymrXFeieH6g
 2P/y38VgKXHOkdesfyyowXaiN9XCVHz58sTP+4ohEF0fVAAMOgLhIFV/0H14ozx6XGgA
 74G9TZiHUNfJKYSjkSBXhpb6zjwTfciKNoD2ihaxrF3a7B7Xuk1rt/Luf9vu/7RQCPhS
 F/95/dj892YUDwJ732dwypS+Ic8tT+v/fw7/wGBYzwjftg/Li1BGg9205omPbEmC2kQt
 kE3A==
X-Gm-Message-State: AOJu0YwvPtUpoNV9Ggbc61jUA5VSaKb7Vr650Fs++lXH94Oz3itjYeab
 B9p9dLVN9VkKmb2wQZDbjeSbuZPfR4ApTbNWLur4ffh76TNy66g8iOnpOa/GUIJEepV6iTixuTr
 WvSPALpOltomtJAM=
X-Received: by 2002:a2e:a706:0:b0:2b6:a804:4cc with SMTP id
 s6-20020a2ea706000000b002b6a80404ccmr9281852lje.53.1698762850302; 
 Tue, 31 Oct 2023 07:34:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhcvk0A8csPhVPN5mbjZwFqBLr5s/Q8/Q/6Y3T5fOIlV89akMpLIFkE+bIpvBVD78FDxvzdQ==
X-Received: by 2002:a2e:a706:0:b0:2b6:a804:4cc with SMTP id
 s6-20020a2ea706000000b002b6a80404ccmr9281833lje.53.1698762849930; 
 Tue, 31 Oct 2023 07:34:09 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c4e9100b00405c7591b09sm1939070wmq.35.2023.10.31.07.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:34:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 5/5] migration: Change ram_save_queue_pages() retval
 to bool
In-Reply-To: <20231017202633.296756-6-peterx@redhat.com> (Peter Xu's message
 of "Tue, 17 Oct 2023 16:26:33 -0400")
References: <20231017202633.296756-1-peterx@redhat.com>
 <20231017202633.296756-6-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 15:34:08 +0100
Message-ID: <87a5ry7ten.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

Peter Xu <peterx@redhat.com> wrote:
> After we have errp which contains the more detailed error message, make
> ram_save_queue_pages() returns bool in its stack.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.h       |  4 ++--
>  migration/migration.c | 16 ++++++++--------
>  migration/ram.c       | 18 +++++++++---------
>  3 files changed, 19 insertions(+), 19 deletions(-)
>

>  static bool migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
> @@ -1990,8 +1992,7 @@ static void *source_return_path_thread(void *opaque)
>          case MIG_RP_MSG_REQ_PAGES:
>              start = ldq_be_p(buf);
>              len = ldl_be_p(buf + 8);
> -            migrate_handle_rp_req_pages(ms, NULL, start, len, &err);
> -            if (err) {
> +            if (!migrate_handle_rp_req_pages(ms, NULL, start, len, &err)) {

I thought we were headed the other direction.
Make functions return void and just check if the error is set.

I think just change the type form returning int to return void will make
the trick.

Later, Juan.


