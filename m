Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5172E890
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 18:33:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q96wd-0005tX-8O; Tue, 13 Jun 2023 12:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96wW-0005tA-78
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96wU-0002It-El
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686673945;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOIKBSk0ZRzZIt/z8W2CBO7jpmTBWTfwGTBbnqvDgQU=;
 b=i7ROEMZFqFJhjm4HQvRzrMFevx1vYn7SayMK5RrItnwSlJ8TrRf/IArxw+0ZFgI7/1GZ4F
 uJ/IMRZwiePk5CkI/cwQm+nJt6Jrr3ox4XymWUwogW4s7r/pHC/GkIIwc7XTZCzamokXhm
 bjPX48DbfV9cHWDiqQWOonRBVZm44U8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-k2sSbN3NMQekJiIs8JO4Nw-1; Tue, 13 Jun 2023 12:32:23 -0400
X-MC-Unique: k2sSbN3NMQekJiIs8JO4Nw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30fcc3125acso523291f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 09:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686673941; x=1689265941;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yOIKBSk0ZRzZIt/z8W2CBO7jpmTBWTfwGTBbnqvDgQU=;
 b=YA8GFcJy5fDFEKgOdaEeI0e6vcZd1vac469JgJlQYwgkevcmK3A3FZQSIPfYGMz6gc
 VaOfrrTwEjDg3QpmrStp/run5q17ON9+b/ZnkRzyd/6/pQgELU8VscSOhvKlLKKBuIEu
 YHVVUi81UhXPIPTVeAqqJ8XghvMfnCw2bdWiiO0GwjQgRjn62JqL3nUpDLjlZzJELv33
 KzGJuPlGg9vnDZUYRTg1qbsSYoWWesQpzvIYqv1Iw7m+FMgrgsL6CYfgsx/y2V2+gHSx
 jBxtgHRvYujTXHWEKCaHcUxAdGlExxJmZ1Q2TW9WwtpMaMeL5mg4CUo3rzN419LplVXH
 qlNw==
X-Gm-Message-State: AC+VfDzPSwR6Jx4xJ7VGe3YI/wKbpskxH+VW2+6XgWO8dZ1XoosLlSe+
 LD4Ip/CHaAhrDLzFTM4wTucxStjmihnsn4WLWBmWpgw8jFolKHwNN3L5kKQxZ8EfQ24BuN+saAc
 D+cd6lfV1AWTml2M=
X-Received: by 2002:a5d:4b86:0:b0:30d:5cce:3bb5 with SMTP id
 b6-20020a5d4b86000000b0030d5cce3bb5mr6267112wrt.60.1686673940840; 
 Tue, 13 Jun 2023 09:32:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GmtN5URTmfeifmmKet+vnNIWt1K7vyenAWOMSKBuq8nAR1tNaONo73n95GHsdiXnaJHOihA==
X-Received: by 2002:a5d:4b86:0:b0:30d:5cce:3bb5 with SMTP id
 b6-20020a5d4b86000000b0030d5cce3bb5mr6267090wrt.60.1686673940434; 
 Tue, 13 Jun 2023 09:32:20 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 v13-20020adfebcd000000b00309382eb047sm15964275wrn.112.2023.06.13.09.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 09:32:19 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v5 4/8] migration: Introduce dirty-limit capability
In-Reply-To: <168618975839.6361.17407633874747688653-4@git.sr.ht>
 (hyman@git.sr.ht's message of "Wed, 07 Jun 2023 23:30:50 +0800")
References: <168618975839.6361.17407633874747688653-4@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 18:32:19 +0200
Message-ID: <87a5x3e31o.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

~hyman <hyman@git.sr.ht> wrote:
> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Introduce migration dirty-limit capability, which can
> be turned on before live migration and limit dirty
> page rate durty live migration.
>
> Introduce migrate_dirty_limit function to help check
> if dirty-limit capability enabled during live migration.
>
> Meanwhile, refactor vcpu_dirty_rate_stat_collect
> so that period can be configured instead of hardcoded.
>
> dirty-limit capability is kind of like auto-converge
> but using dirty limit instead of traditional cpu-throttle
> to throttle guest down. To enable this feature, turn on
> the dirty-limit capability before live migration using
> migrate-set-capabilities, and set the parameters
> "x-vcpu-dirty-limit-period", "vcpu-dirty-limit" suitably
> to speed up convergence.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Acked-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
>      return s->capabilities[MIGRATION_CAPABILITY_AUTO_CONVERGE];
>  }
>=20=20
> +bool migrate_dirty_limit(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +
> +    return s->capabilities[MIGRATION_CAPABILITY_DIRTY_LIMIT];
> +}
> +

Not sorted O:-)

I know, I know, no docs.


> +    vcpu_calculate_dirtyrate(period,
> +                              &stat,
> +                              GLOBAL_DIRTY_LIMIT,
> +                              false);

spaces, tabs and/or editor failed you.

Will fix by hand.

Later, Juan.


