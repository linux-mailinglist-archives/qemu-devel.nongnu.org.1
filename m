Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CCE7EE2A3
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 15:21:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3dDq-0006fZ-G8; Thu, 16 Nov 2023 09:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3dDg-0006fQ-8A
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:19:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3dDe-0001cG-Is
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700144385;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HRFNKzqFiST3oYbmKIvuoQnRugkHg/QWVhIDWj8kHKU=;
 b=gz3oxKrL6JFs7mW3du+9KEdQhNeDloYiDKAiMgzAaNJcc4fAyBObUL/QEzFX3dG4YMTenG
 FmixCPEK2WcqANc1mMvPgsNjkoxG1Jn+35BfiYo+rjfeKUsT/IVg81TL5WXOuu2xpDSj2T
 YFWCLjuUZQyJewGZXyfpqYMedC1T44Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-VClaEzA8OSqauAhfphH0Vw-1; Thu, 16 Nov 2023 09:19:43 -0500
X-MC-Unique: VClaEzA8OSqauAhfphH0Vw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40839252e81so4840675e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 06:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700144382; x=1700749182;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HRFNKzqFiST3oYbmKIvuoQnRugkHg/QWVhIDWj8kHKU=;
 b=xLSLHusys0/JTdTpgTkkEC/mtmD+9+C2eU8f73e09drxOYMzd9cM4O2x6NU7p60lio
 RwYf/gFpKrk3PWGNVu7DTv4PJevbLWfw2DiEIfQ7VYO+DIqHLJS8dT8Uu4C4E1O4lHtb
 Ci4HLBVDAyY83/Nh5lixuHQIheAeOsZB40iM8ggD8ReTkG3nq7R6/l31ZXgdlJ6Db2GR
 6rhH4UNnR4UjMF8ZdbUI0TM6MvaL74iU4lDwwVR2DqXtl62NiMp+JNWMF7puZvy7OxA8
 PNUJ4JZKO+MBeWDkAj53JZL06+cT40xT/h2S5GXusf88Xe4NPXgp0+2KVVqLnnDHQWbZ
 LFTg==
X-Gm-Message-State: AOJu0YyHcCjTEh3GI7kfLgn/8l/ANCkFLzwnWV2mmTpKAErTy3fP5Kq1
 v4Lqb45QtfNyhI27Vo035XsgqFacXucp65vVhOowj799IHk6U+6Pm217MN20b8Ef+xS84lUVYBq
 A0H2+gHrs0wMSTlE=
X-Received: by 2002:a05:600c:46d5:b0:3f9:b430:199b with SMTP id
 q21-20020a05600c46d500b003f9b430199bmr11305993wmo.15.1700144382379; 
 Thu, 16 Nov 2023 06:19:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE5UQAjMDzLomCwZBr3Yj2cnp6M8Ury7TVzLkw6vq1BilkqlNU2lpvqPemHw88q2piBkNuNQ==
X-Received: by 2002:a05:600c:46d5:b0:3f9:b430:199b with SMTP id
 q21-20020a05600c46d500b003f9b430199bmr11305976wmo.15.1700144382012; 
 Thu, 16 Nov 2023 06:19:42 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 n13-20020a05600c500d00b004083996dad8sm3866030wmr.18.2023.11.16.06.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 06:19:41 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc: peterx@redhat.com,  berrange@redhat.com,  farosas@suse.de,
 leobras@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2] migration: free 'saddr' since be no longer used
In-Reply-To: <20231116063448.2333616-1-zhouzongmin@kylinos.cn> (Zongmin Zhou's
 message of "Thu, 16 Nov 2023 14:34:48 +0800")
References: <ZVT1c3Ptd_P3Nfb_@x1n>
 <20231116063448.2333616-1-zhouzongmin@kylinos.cn>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 16 Nov 2023 15:19:40 +0100
Message-ID: <87il61rdab.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Zongmin Zhou <zhouzongmin@kylinos.cn> wrote:
> Since socket_parse() will allocate memory for 'saddr',and its value
> will pass to 'addr' that allocated by migrate_uri_parse(),
> then 'saddr' will no longer used,need to free.
> But due to 'saddr->u' is shallow copying the contents of the union,
> the members of this union containing allocated strings,and will be used after that.
> So just free 'saddr' itself without doing a deep free on the contents of the SocketAddress.
>
> Fixes: 72a8192e225c ("migration: convert migration 'uri' into 'MigrateAddress'")
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> ---
>  migration/migration.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 28a34c9068..9bdbcdaf49 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -493,6 +493,7 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>          }
>          addr->u.socket.type = saddr->type;
>          addr->u.socket.u = saddr->u;
> +        g_free(saddr);
>      } else if (strstart(uri, "file:", NULL)) {
>          addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
>          addr->u.file.filename = g_strdup(uri + strlen("file:"));

Once that we are here, can we move the declaration of saddr to this
block, so we are sure that we don't use saddr anywhere?

As Peter said, putting a comment why we don't use
qapi_free_SocketAddress() will be a good idea.

Later, Juan.


