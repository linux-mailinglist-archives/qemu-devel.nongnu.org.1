Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A17E55DD
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 13:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0hD6-0005iS-EB; Wed, 08 Nov 2023 06:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r0hD4-0005i1-EQ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r0hCx-0007co-Nq
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699444733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6N2ChRa1sb9NmKGcc3xfDk8X2qA9gCkqmJSCVGuX0c=;
 b=F+zXxboow6qTswxI9gj6ehYi76uMrBWTS9MjZoCM+tTFHd2hSbgU4Rdpt13zWniLysyqjY
 dCkcGB2nuU0UMqkBQBnilwXp8e/Mq4BgiPJe3+ymzfdtfm0itcZkibQ794T0m8KmuGfE0+
 L1hU1qCwlivLcdQcf0i/lNruH8NQ1Wg=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-LrF_l2WCM4mZIxIVaWVEWA-1; Wed, 08 Nov 2023 06:58:52 -0500
X-MC-Unique: LrF_l2WCM4mZIxIVaWVEWA-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7ba672cc8b3so1948031241.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 03:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699444731; x=1700049531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6N2ChRa1sb9NmKGcc3xfDk8X2qA9gCkqmJSCVGuX0c=;
 b=b+qeEOEzkuGfcNFsy3y8ECUQrW6BxpZC9t0hQuBMkmftyqN2fX1ap9bIc4VDcFiNyW
 TveMwSVDUspdAREiuTZOr5jVk4VOzXLBk7QF7WrBpVeJ/wzj9bIiuFcYbG3ztgaMnFzc
 +FJ8PXPAtvlTOVrb7+Lt4eZGcnVMJBzInKFC7oGMYvycnlFzdl7h5nE55kNJDokFPrLz
 n2LW5xeR9JfeULxBSAPNYgEIDLx311jqSWyWyrurfvquwnn19cg9MONRvorAZ4/kQkTT
 38qXMKI075PeUeDfzUMQMBU0i4k6rJwyaN2j9eyVivrbAeMHo5WKBF2V1KphuDo8s75d
 wYpA==
X-Gm-Message-State: AOJu0YzSzP2C53ELQpyApyIWhSC9Zb9yi6RugKRLHD8Jf1LmyagF7c/Y
 RusfPjwzhuOf/qS8GCfhfRgVXFBvNuFsnW8W7DRvojMKH29XiO8ZS48fSyBPTUa5tvAcd8c/ZO7
 9wyB97Ca+mOhiSamoBZ1Ve9DVBkZY0sM=
X-Received: by 2002:a67:b802:0:b0:45d:a302:54be with SMTP id
 i2-20020a67b802000000b0045da30254bemr1434911vsf.25.1699444731603; 
 Wed, 08 Nov 2023 03:58:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmWOD6P2P5wlyPT66v0u/fWA1MR8bgW+wA0Uw6vzSX0i7lTStVo8WjXPwNBLWdh4VSmgf+4INC/vhJQd8NTEM=
X-Received: by 2002:a67:b802:0:b0:45d:a302:54be with SMTP id
 i2-20020a67b802000000b0045da30254bemr1434886vsf.25.1699444731364; Wed, 08 Nov
 2023 03:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-15-alex.bennee@linaro.org>
 <ea92d71f-35a3-4a5f-bece-01436a33e1e8@redhat.com>
 <CWXP123MB4341A5286537C5060BA71FB8D7A9A@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
 <CWXP123MB4341C5B85F101081C325619CD7A9A@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP123MB4341C5B85F101081C325619CD7A9A@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 8 Nov 2023 12:58:39 +0100
Message-ID: <CABgObfbW=8ywhUiWaZeT5pS_xCXuwJirMsQe=Q1ar=rEM_ytAQ@mail.gmail.com>
Subject: Re: [PATCH 14/22] plugins: make test/example plugins work on windows
To: Greg Manning <gmanning@rapitasystems.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 7, 2023 at 1:43=E2=80=AFPM Greg Manning <gmanning@rapitasystems=
.com> wrote:
> Windows will look for __pfnDliFailureHook2 in the module doing the delay
> loading, which in this case is the plugin DLL.

Fair enough, this is what was not clear from the Microsoft docs.

Paolo


