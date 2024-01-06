Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC2C8260EE
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 18:45:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMAiZ-0001tq-9O; Sat, 06 Jan 2024 12:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rMAiQ-0001qZ-Tb
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 12:44:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rMAiO-00065l-LC
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 12:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704563045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAFhZZ5z8kM7eJH3ZhnX5dwUABNYfaGlxPDj7HVKXzM=;
 b=D+2NFwLnSnLrf4GSSmaaH/vc9AS7dMRhJCfY3/Jg0mx74RW0YNN7ZpnB0mccZGrrccc9El
 SEwZe5nq023Zb+ESnvZ5kRO9rCVtr5rDilLSUPkUalub/9p7aIIoltHpqudfJ+qslkR4c6
 X9eLC+8DkA4pc+cAp/bkape9ClVwsnE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-IoU_UImRP_uIUltrpv5B5g-1; Sat, 06 Jan 2024 12:44:01 -0500
X-MC-Unique: IoU_UImRP_uIUltrpv5B5g-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6dbffa4b034so708574a34.3
 for <qemu-devel@nongnu.org>; Sat, 06 Jan 2024 09:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704563041; x=1705167841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAFhZZ5z8kM7eJH3ZhnX5dwUABNYfaGlxPDj7HVKXzM=;
 b=AAtb3KjVfXGtAsQ8UZEOyEIGjSW+l44SKu2MQYJmMpPZlEoH/H7UtznRR05STvUt3C
 OeBzvxoyw4mbsAo+Vb16wM1jtnj2jMWJq0dunj2500RgNTNIMulG8HRAp/3k477SKXZm
 XoVnIcIIDzL74/sMyzDTeARUGTBpJ9NCUpFFQegulDcbjEm1rqhoWPTiRiWcFrvaiFMW
 QPJy+n+54dUkRztLMAQ70NemnsuE5fmwIHpstTAWxiHf6rxIJWHHFDv8KGwXPNjKKl3D
 DnXLR7t4FXvFiVdQDMjqxYoX4Lw1Jb3qlIjqjLRaLvAlVJjRrYoeCiMFmn6HoP1jDsEI
 jPoQ==
X-Gm-Message-State: AOJu0Yxn2NUsr50Vg+g39wK474IcTl+AbGLcvGuf8fxMszSTKGbVtwit
 3BBxACh5ymHT6xxwaJCdDlWR4Lnq+A6swFO3YoD6rXO51t83DVU+jpun8XnRm5YCSQCWlMPzMS4
 90ahbBP+FE5uU8uaSOJ46jUciAD2ClCAckATOEKQ=
X-Received: by 2002:a05:6830:118:b0:6dc:18e3:78d4 with SMTP id
 i24-20020a056830011800b006dc18e378d4mr968742otp.59.1704563041212; 
 Sat, 06 Jan 2024 09:44:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEt6lFZth+tdL5AaUcWaKYP8Y4SjV8/H+3VYQx6QP52FrLUeHl+e0Nez6CKwBtHXw5djxeWZ57thG4aj3z/aX8=
X-Received: by 2002:a05:6830:118:b0:6dc:18e3:78d4 with SMTP id
 i24-20020a056830011800b006dc18e378d4mr968738otp.59.1704563040896; Sat, 06 Jan
 2024 09:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20231028194522.245170-1-richard.henderson@linaro.org>
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 6 Jan 2024 18:43:48 +0100
Message-ID: <CABgObfZme6gNZG=3ibXb8=+yAg=LHPeHYdncdx2LgN741bk_7A@mail.gmail.com>
Subject: Re: [PATCH v2 00/35] tcg: Introduce TCG_COND_TST{EQ,NE}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, Oct 28, 2023 at 9:45=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Expose a pair of comparison operators that map to the "test"
> comparison that is available on many architectures.
>
> Changes for v2:
>   * Add TCGCond to tcg_target_const_match.
>     This fixes a long-standing issue with ppc and s390x backends,
>     in that CMPI for signed comparisons has signed immediate and
>     CMPLI for unsigned comparisons has unsigned immediate.
>     But now allows different immediates for the TST comparisons.
>   * tcg/i386: Generate TEST x,x for power-of-two in {7,15,31,63}.
>   * tcg/i386: Generate BT n,x for other power-of-two.
>   * tcg/ppc: tcg_target_const_match improvements
>   * tcg/s390x: tcg_target_const_match improvements
>   * target/m68k: Use TST{EQ,NE} for gen_fcc_cond.

I updated the MIPS backend (untested though) and pushed the result to
branch i386 of https://gitlab.com/bonzini/qemu/.

However I was thinking: a lot of RISC targets simply do AND/ANDI
followed by the sequence used for TCG_COND_NE.  Would it make sense to
have a TCG_TARGET_SUPPORTS_TST bit and, if absent, lower TSTEQ/TSTNE
to AND+EQ/NE directly in the optimizer?  And for brcond2/setcond2,
always using AND/AND/OR may work just as well as any backend-specific
trick, and will give more freedom to the register allocator.

This also would allow to reorder the target patches before the TCG
patches, thus: 1) providing more exposure to the lowering code 2)
making the "minimum viable series" smaller. (2) is not a huge deal
since you have already written the backend code, but (1) is
interesting.

Paolo


