Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C17747DF049
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:38:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyV4e-0001Qk-RX; Thu, 02 Nov 2023 06:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyV4c-0001Pn-Ih
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyV4a-0007tz-2n
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698921430;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UnT8cMbPz4oB7XTJ2RU9UXCZ6SVVVIOTrvfk5J/CbnI=;
 b=TtbOInA/QpEeOO7k2cW/Hq+Sd5JubxtyVzzqaXBqRUo79dKYAZ2ShnU2/x5dC7TBWujXEe
 yIlhHHcv2f278eq22ApWiKhZvZtFvkkLLUYW/LCBQ2SFe+89A1xP/+j5jDv4+T2isoGzuR
 f1n7aF4afsmsnCHat4LGjXxPqZF4HHI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-EH_brPhsMpqIXVyOROqwVA-1; Thu, 02 Nov 2023 06:37:08 -0400
X-MC-Unique: EH_brPhsMpqIXVyOROqwVA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso363934f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698921427; x=1699526227;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UnT8cMbPz4oB7XTJ2RU9UXCZ6SVVVIOTrvfk5J/CbnI=;
 b=mUYoguBnnh52cKEmqKpux2eg6WFXumkqKZhrqmNACEtq579iipQwLEJm4frtYKWFfJ
 dj+s04/RC6ZLUYlpcDhuYMz9OiBI0awSk5dee+NRqPXnu12DpLyAPVLCzr5F21mSVeFB
 ye1ST2UXyhymLYxUxj4g3/R8w7fxPFMCqWvGtpJ6gqrVXShcse5hAAlHHLQJo8C1y91v
 9g6gaoCh75+3UAPK2JN1G6Lohaw5vD35XkgDjIKuPjJxNaoPYgLhmIx4zhW0RbwJ7AYN
 /N6UeqffVDoog00XHeUOx3cO7d6rBVjkDGJLrYUungwqPeH18Vym+XwpkgClsH3+sYE/
 thtg==
X-Gm-Message-State: AOJu0YwtUuLBUQFyf9BDTmnrR6jGYni9XDha5tQwV2x3EPFHcv+TelPQ
 DyEHQ9wU0rXj//IWA7lc1JsjmEYYptdlk9aB8E8vP3bexuIWUtLjHkSG4BN3Pks09mkLvV8i6mb
 0PycNsrgrVKu1qno=
X-Received: by 2002:a05:6000:10f:b0:321:4de3:fd5c with SMTP id
 o15-20020a056000010f00b003214de3fd5cmr12938969wrx.51.1698921427179; 
 Thu, 02 Nov 2023 03:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGub9PnFGlKPhkjrxznfPpE9NPmsE2+5m14c24enag9LliTATINWMRXDegrzszWWZ3s1NiVw==
X-Received: by 2002:a05:6000:10f:b0:321:4de3:fd5c with SMTP id
 o15-20020a056000010f00b003214de3fd5cmr12938957wrx.51.1698921426884; 
 Thu, 02 Nov 2023 03:37:06 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z2-20020adff1c2000000b0032d9a1f2ec3sm2088768wro.27.2023.11.02.03.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:37:06 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [v3 6/6] docs/migration: Add the dirty limit section
In-Reply-To: <0f2b2c63fec22ea23e4926cdeb567b7a0ebd8152.1698847223.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Wed, 1 Nov 2023 22:04:09 +0800")
References: <cover.1698847223.git.yong.huang@smartx.com>
 <0f2b2c63fec22ea23e4926cdeb567b7a0ebd8152.1698847223.git.yong.huang@smartx.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 02 Nov 2023 11:37:05 +0100
Message-ID: <87lebg30ha.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

Hyman Huang <yong.huang@smartx.com> wrote:
> The dirty limit feature has been introduced since the 8.1
> QEMU release but has not reflected in the document, add a
> section for that.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Message-Id: <36194a8a23d937392bf13d9fff8e898030c827a3.1697815117.git.yong.huang@smartx.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I queued the whole series.  I didn't comment about the guestperf script
changes because I am not familiar with that part.


> ---
>  docs/devel/migration.rst | 71 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index be913630c3..12c35f9bc4 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -590,6 +590,77 @@ path.
>       Return path  - opened by main thread, written by main thread AND postcopy
>       thread (protected by rp_mutex)
>  
> +Dirty limit
> +=====================

Too long, I fixed it by hand.


