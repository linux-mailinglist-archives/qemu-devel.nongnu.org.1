Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC87737F02
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:32:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuBf-0006sK-Fn; Wed, 21 Jun 2023 05:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBuBc-0006s1-L1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBuBb-00047a-4O
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687339893;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ev/hq7KHIUxF0LDCLZZLc8XkDrM2ecryDa0I8nAUph0=;
 b=JpsLRz7IyphNJJYRZtxDn/hROmgRFUiUgMiqz+GNVxe7Kd6EsNGaCRqj0ahNgrBmrqlNoH
 BSVGg15FNF52GSfjB8J9tjQdkwGZ+F4s8o+Vu3pvL/S4T0I/k7UqAFdv/3sagz3bfjDtJ0
 gF7JfD9zsRmlwcyJm2QUHbjR6CblLjQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-1SvwyCeQMRKNUQktUyAk4w-1; Wed, 21 Jun 2023 05:31:32 -0400
X-MC-Unique: 1SvwyCeQMRKNUQktUyAk4w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f7e7cfcae4so30700555e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687339891; x=1689931891;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ev/hq7KHIUxF0LDCLZZLc8XkDrM2ecryDa0I8nAUph0=;
 b=JYGKTGxEbMv+XNl8R6SxeFn+S4LFJSUWJun55zErKWpm1HJH6j/iWZLTrD4EMRhlhV
 2gUDqLYmlrTg28I9DR3dZ2qCBinN+M14rRH3Ls+sXQ7UARvPEaaaZC5JY15L6lpNkFzE
 49LuHY3eCSucz5AVrNq5c0hTl9UDizAATmj6e6E0aZShcJtaryG6jV+bcdILsx/kqQdv
 HRYsNbU3RnSTCTEshsbIS8C5EkwsGYB4FCh+D5NaerYv8BaB7+Pp2vCL3Pfer3dVkYCL
 jcbMYI5Capxz21J6u7RoHFLWJyTbL6ajXUtbYGeHBP/QrSW27mUPxTkebvxbgDxdWQpa
 7Uyg==
X-Gm-Message-State: AC+VfDzZO/KRTREFzPBgWHbsrwx2zDScjTarsga/6qUrnYP+VyYFN1Va
 dViUybRYAk921n2B1T7LyTzfk/EjqJaRdZbRlyvIU5fCq0n53+oq/R02JAQaXKZZxLkXZ3/T/LP
 +6lQXxutqxqwWoDs=
X-Received: by 2002:a1c:4b04:0:b0:3f9:aca:48c4 with SMTP id
 y4-20020a1c4b04000000b003f90aca48c4mr9359510wma.23.1687339891588; 
 Wed, 21 Jun 2023 02:31:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HsWiVL4DXslHe3mH6jKwxA2ocoT6sUFgmNx48u+qInzxxIrGfLfR+cCNWZB2u1KKm/CaH+w==
X-Received: by 2002:a1c:4b04:0:b0:3f9:aca:48c4 with SMTP id
 y4-20020a1c4b04000000b003f90aca48c4mr9359496wma.23.1687339891302; 
 Wed, 21 Jun 2023 02:31:31 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 t13-20020a1c770d000000b003f91e32b1ebsm9051709wmi.17.2023.06.21.02.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 02:31:30 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v6 8/9] migration: Extend query-migrate to provide
 dirty page limit info
In-Reply-To: <168733225273.5845.15871826788879741674-8@git.sr.ht>
 (hyman@git.sr.ht's message of "Thu, 08 Jun 2023 00:21:58 +0800")
References: <168733225273.5845.15871826788879741674-8@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 11:31:29 +0200
Message-ID: <87ttv1b1qm.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

~hyman <hyman@git.sr.ht> wrote:
> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Extend query-migrate to provide throttle time and estimated
> ring full time with dirty-limit capability enabled, through which
> we can observe if dirty limit take effect during live migration.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I am assuming that you mean reviewed-by here (and in previous ones)?

> Reviewed-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


