Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F61709D1A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:03:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03Ts-00018z-Nn; Fri, 19 May 2023 13:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q03Tq-00018j-Vv
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:01:27 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q03Tp-0004z3-7q
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:01:26 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-510dabb3989so5286329a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684515682; x=1687107682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0fX1Fu3jckq8fxBGbCxQ3Say7Sv9jCRqYc7Ap4ziXo=;
 b=MbZ2KI0v6axU3qcNIS8CVARWfxH59Pdhy0/jZcGPvQXk3bd+rhbDk0zJgVsYPHOFjU
 5pFTroHJVv9IVyetsob02n/cWKSxMjhxjsyrtUfRtKKZ0P0tuP2WyiJIHoFLlkpe8wpu
 5lAExQb5TRsG/7FaeO6bW6ZmL0XlIPehqNJe1Id/X61yPuPOpgas/T8s8Kk1y7caHVOL
 IW29850Wwkje1qOro2ytKk5pjJUUHdjHNWGYQHIM/3D3NpTAmcyMzvFHi2FrhnYIrz8U
 JkAUAPieZoi0KgLW+F5WZ40CtAgRm5FTr/djCauKWLfUT0x3mPnrF0Wckqf992OHvfIh
 ykuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515682; x=1687107682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0fX1Fu3jckq8fxBGbCxQ3Say7Sv9jCRqYc7Ap4ziXo=;
 b=DfGiOoqHrQ1RUcvjKORF26Y4O7p9W0zxUmLUTdLReh+hRorBRrBhcWl4OogTdD1THC
 krMLRDluU8UMy4gQy4kgjWTx6+8QSRmlfInb/IEzakE8B7Ze/92nsXEyxHXEQ4hcNdoq
 2G8qdtkbaacXnlC85ua4K/pDYfBKWapSiLyGnJpKYLIbfnJQcd47MOJeXn/DjJMSlRdV
 mxY89K50eb3GPFfgQ24HGtdD798lZMlIEUaRedEiWHREkf3O+jHVbBmHiHX1edJJoH/C
 FIS5456GFbHJY0tdHNfh2FP3CkrTWsdZvUsFkSlm8ne9nOtItFGgAUWYm9HvYujmISa1
 p47A==
X-Gm-Message-State: AC+VfDxyWgmvkxZklIrTEDCkbg9gXy+Jjo3Zklsi3JPZvehZ1PkcLKaU
 vv89Yv+BDh6/u6AeqZ+VdA3N+U7EZAe+NahmfQ/pmA==
X-Google-Smtp-Source: ACHHUZ4m6eNVuKw7cPNGMzVAQDiIi9+uWN3YVTe4VfCyJbjabf7e4qvBbqjdtviyUFtfZps2riWxo+bryl4NBrusEiw=
X-Received: by 2002:aa7:d888:0:b0:510:d929:f25f with SMTP id
 u8-20020aa7d888000000b00510d929f25fmr2128844edq.28.1684515682425; Fri, 19 May
 2023 10:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230518114025.1006732-1-pbonzini@redhat.com>
 <CAFEAcA-ZtAHC2frNzVymYf9pufyi6Y1wHeLnKLrne7NaTeqNfw@mail.gmail.com>
 <CABgObfbk=8Uq3gN1dThxq3jJOAEk_cGu0Y4bvRtvdR9xZ2xtxw@mail.gmail.com>
In-Reply-To: <CABgObfbk=8Uq3gN1dThxq3jJOAEk_cGu0Y4bvRtvdR9xZ2xtxw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 May 2023 18:01:11 +0100
Message-ID: <CAFEAcA_4_JD46CxkT2dcXSLHKNsa7kKYPYJkqEzZERDTK_wx-A@mail.gmail.com>
Subject: Re: [PULL v3 00/68] i386, build system, KVM changes for 2023-05-18
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/mixed; boundary="000000000000decb5605fc0ede50"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--000000000000decb5605fc0ede50
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 May 2023 at 17:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
>
> Il ven 19 mag 2023, 16:39 Peter Maydell <peter.maydell@linaro.org> ha scritto:
>>
>> On Thu, 18 May 2023 at 12:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > ----------------------------------------------------------------
>> > * kvm: enable dirty ring for arm64
>> > * target/i386: new features
>> > * target/i386: AVX fixes
>> > * configure: create a python venv unconditionally
>> > * meson: bump to 0.63.0 and move tests from configure
>> > * meson: Pass -j option to sphinx
>> > * drop support for Python 3.6
>> > * fix check-python-tox
>> > * fix "make clean" in the source directory
>>
>> Hi; this seems to have broken builds from not-clean on my system.
>> Blowing away the build tree and recreating it from scratch
>> works, as does manually re-running configure,
>> but the Makefile ought to re-run parts of configure
>> etc when it needs to.
>
>
> Can you send your config-host.mak after a failed rebuild? I think what's happening is that the path to meson has changed but Makefile still tries the old one (which could be the system meson in /usr/bin).

Attached; it has
MESON=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/pyvenv/bin/meson

That meson says:
$ /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/pyvenv/bin/meson
--version
1.1.0

1.1.0 is neither the system meson (which is 0.61.2) nor
the version the build system wants (0.63.0) nor the
version that it complains that it's found (0.61.5),
so I'm not sure what's going on there...

> If so, you should be able to get out of the breakage by adding
>
> MESON=pyvenv/bin/meson
>
> after the "-include config-host.mak" line.

This had no effect (unsurprising given that it's the same meson
as the config-host.mak specifies).

-- PMM

--000000000000decb5605fc0ede50
Content-Type: text/x-makefile; charset="US-ASCII"; name="config-host.mak"
Content-Disposition: attachment; filename="config-host.mak"
Content-Transfer-Encoding: base64
Content-ID: <f_lhut49p10>
X-Attachment-Id: f_lhut49p10

IyBBdXRvbWF0aWNhbGx5IGdlbmVyYXRlZCBieSBjb25maWd1cmUgLSBkbyBub3QgbW9kaWZ5Cgph
bGw6CkdJVD1naXQKR0lUX1NVQk1PRFVMRVM9dWkva2V5Y29kZW1hcGRiIHRlc3RzL2ZwL2Jlcmtl
bGV5LXRlc3RmbG9hdC0zIHRlc3RzL2ZwL2JlcmtlbGV5LXNvZnRmbG9hdC0zIGR0YwpHSVRfU1VC
TU9EVUxFU19BQ1RJT049dXBkYXRlCkNPTkZJR19ERUJVR19UQ0c9eQpDT05GSUdfUE9TSVg9eQpD
T05GSUdfTElOVVg9eQpTUkNfUEFUSD0vbW50L252bWVkaXNrL2xpbmFyby9xZW11LWZyb20tbGFw
dG9wL3FlbXUKVEFSR0VUX0RJUlM9eDg2XzY0LXNvZnRtbXUgaTM4Ni1zb2Z0bW11IHg4Nl82NC1s
aW51eC11c2VyIGkzODYtbGludXgtdXNlcgpDT05GSUdfUExVR0lOPXkKSEFWRV9HREJfQklOPS91
c3IvYmluL2dkYi1tdWx0aWFyY2gKUk9NUz0KTUFLRT1tYWtlClBZVEhPTj0vbW50L252bWVkaXNr
L2xpbmFyby9xZW11LWZyb20tbGFwdG9wL3FlbXUvYnVpbGQveDg2LXRndHMvcHl2ZW52L2Jpbi9w
eXRob24zIC1CCkdFTklTT0lNQUdFPS91c3IvYmluL2dlbmlzb2ltYWdlCk1FU09OPS9tbnQvbnZt
ZWRpc2svbGluYXJvL3FlbXUtZnJvbS1sYXB0b3AvcWVtdS9idWlsZC94ODYtdGd0cy9weXZlbnYv
YmluL21lc29uCk5JTkpBPS91c3IvYmluL25pbmphClBLR19DT05GSUc9cGtnLWNvbmZpZwpDQz1j
YwpFWEVTVUY9ClRDR19URVNUU19UQVJHRVRTPSB4ODZfNjQtc29mdG1tdSB4ODZfNjQtbGludXgt
dXNlcgo=
--000000000000decb5605fc0ede50--

