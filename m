Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E37C5570
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZGZ-0004lw-GJ; Wed, 11 Oct 2023 09:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZGX-0004lm-Ns
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZGW-0005vZ-4z
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697030923;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7NvXWyPnHft5pEy3DWd0l35J4ASe7HvziYSApTZPZac=;
 b=Si8LR2Chmd0/IIutFPYEi1BLKJfBLSlQ6kCgGcfohUqtqsC9UgyfJDNEsx1KwcuhmbC7IW
 s5Q7MZ/yo1uVXi03qP1yn/09/pbOklObFRIYJOFvB0uUh3M6/ZV/T6oASwbrLj2tshepOv
 lvGmTigrkFdjzYAbO2onr220kdHxKUA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-9YtZleh-O62gTA39DUqy3g-1; Wed, 11 Oct 2023 09:28:42 -0400
X-MC-Unique: 9YtZleh-O62gTA39DUqy3g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d040c58eeso9664376d6.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030921; x=1697635721;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NvXWyPnHft5pEy3DWd0l35J4ASe7HvziYSApTZPZac=;
 b=CZo9JTpCErqGjPMZ52fAyrgmc25YOm619PW8OldO4ukuL472luyUNmnYGP0XGvSm/N
 39VrTF26JbUSNhbQw644OlhuDpc8kmEfsxCHEL5AZtmS4kfgBUv1zFX+IIPpMMiPRrWv
 5E+azihFePexJNRL/5+qolMtWrhfI3rC+j+GuxDKV1RpRZ9XMEbZDb+4H9iZgo4IFNXP
 f2D+rhLIag/a8BemdnC5uh54EnkuWqHFZVRsPCwoq0xaKC+X6IHU1uEt9N8QBm885g5Z
 IU0d2gg+VZuN90xGQ/5+61k+J6gHaQFIU1OrOXh6jbygjgv6ZTaHiz61SwE3rooeaobY
 rcGA==
X-Gm-Message-State: AOJu0YzAi+6I3lKR9m6BPZySl3Kkw4h6Ed6NEb0F9iV+gzVNatcu2FMk
 NcL6x+snQwiM9/MzsX6hAltVubCKXq3FDmWx5rvlUuxZBv11RRsTiwNLiEbSrRuyTdXfAov1Zkz
 DGRUyGTAIcl726pY=
X-Received: by 2002:a0c:aa0c:0:b0:66c:faa7:c5f0 with SMTP id
 d12-20020a0caa0c000000b0066cfaa7c5f0mr3719869qvb.63.1697030921653; 
 Wed, 11 Oct 2023 06:28:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR/bY9A9OuSgJwV3dDFPIteaghN+x3qOvZ/BEJa5ErFLorIQ68scHxhR6ayxANsKbVrb4Rxw==
X-Received: by 2002:a0c:aa0c:0:b0:66c:faa7:c5f0 with SMTP id
 d12-20020a0caa0c000000b0066cfaa7c5f0mr3719844qvb.63.1697030921272; 
 Wed, 11 Oct 2023 06:28:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 di12-20020ad458ec000000b0065af657ddf7sm441823qvb.144.2023.10.11.06.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:28:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/6] tests/qtest/migration: Add a test for the
 analyze-migration script
In-Reply-To: <20231009184326.15777-7-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 9 Oct 2023 15:43:26 -0300")
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-7-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 15:28:38 +0200
Message-ID: <87mswp9tkp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> wrote:
> Add a smoke test that migrates to a file and gives it to the
> script. It should catch the most annoying errors such as changes in
> the ram flags.
>
> After code has been merged it becomes way harder to figure out what is
> causing the script to fail, the person making the change is the most
> likely to know right away what the problem is.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> ---
>  tests/qtest/meson.build      |  2 ++
>  tests/qtest/migration-test.c | 60 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 1fba07f4ed..5e82eccb62 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -356,6 +356,8 @@ foreach dir : target_dirs
>      test_deps += [qsd]
>    endif
>  
> +  qtest_env.set('PYTHON', python.full_path())
> +

I accept it, but I think that this part of the test should be in a
different patch so meson people could comment O:-)

> +
> +    pid = fork();

live and see, g_test and qemu don't have a function to execute a script?
Wow.


