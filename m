Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DAD7E4A42
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 22:04:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0TED-0007c5-Gg; Tue, 07 Nov 2023 16:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0TEB-0007bb-Jt
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 16:03:15 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0TE9-0000gh-2h
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 16:03:15 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c504a5e1deso81152361fa.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699390991; x=1699995791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXuqoY6geukOzWUzZoXD3e08EsM9sFK8RmUj+lQuZZ0=;
 b=WA7g7/tr5fP1M05hkM/aBs4G3i/W4xcL3imkl7yrfWdwwcl4+BEXe84tvKqVo+Vc6G
 p0xTmdUFRqil2JC4tgryKux0A/uevQ8PfmI7119rdT82k0e0ozWCoikGxwXtwAg9XHJP
 4kr7RxeWNoQ9WJi/mAt8JVBFCl8OBBw7+kPTDzmhOJU67e7LQsjexRnAfDvdzqFNgr+B
 Tz1HmpMFY0+GviZOyBQc13ysFYfWlhvU0/Nd04FwuJOsZ+piPDN1VnmXwGCAwtagRYpa
 KVVpqnWEb85TTZSjbp+u26dQletmskEMZjOn1Vyxadx6XzyQTyoeMIjth59xdPTgHEPt
 bXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699390991; x=1699995791;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AXuqoY6geukOzWUzZoXD3e08EsM9sFK8RmUj+lQuZZ0=;
 b=TOoNDuk2P0GL6T0Y/yWPbTUTEsOjGhmYhjd6f4lJgvcVNLpwVxNzr0519pJ6O7hQoW
 10yKyBwRxEAJnmLuXK1ORli1lU2ez1cgtUm2xeaWbFOZek+30FF4kmrAQC8LhZoJHZjW
 p3J5rVXjRFyJ80St4T7xE1vskQsOnNxHheCFsUWF7ECeKi478X2CoQuq+D542nXJEOjX
 UXuo68vtsNXz0ynaiXe3TDAVOvDWI4/z+dFdD+4G8zWlGOI76Di3b6ZNuvyzm+MpoOgT
 Bun+sOahudSYpa5KWec9mhJAT+vmjhf6AwZuWHFhSjSC3Afq6BVumiAjQzYPVJhgVcLd
 U//Q==
X-Gm-Message-State: AOJu0YxQMp8DOXKtNfAFRwJtWlYDBE/uPaTMZ0Qu8WMrOrspwuNrDHcj
 3YKEuRTRcnCuG+eLAKzbXL6Eag==
X-Google-Smtp-Source: AGHT+IFfTehy7id+7D2L6wTH/846FRW/v+2g8F7DjtOZb6PrSYJeBPYWzbeW7wOSKPkgPgFCorqxRg==
X-Received: by 2002:a2e:bea3:0:b0:2bc:c650:81b with SMTP id
 a35-20020a2ebea3000000b002bcc650081bmr106045ljr.15.1699390990931; 
 Tue, 07 Nov 2023 13:03:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p29-20020a05600c1d9d00b0040772934b12sm17257981wms.7.2023.11.07.13.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:03:10 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F07A5F792;
 Tue,  7 Nov 2023 21:03:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Beraldo Leal <bleal@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/docker: replace fedora-i386 with debian-i686
In-Reply-To: <ZUqSaKoi7OBil+aM@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 7 Nov 2023 19:39:20 +0000 (1 hour, 23 minutes, 46 seconds ago)")
References: <20231107164109.1449014-1-berrange@redhat.com>
 <87v8ad9x4e.fsf@draig.linaro.org> <ZUqSaKoi7OBil+aM@redhat.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Tue, 07 Nov 2023 21:03:10 +0000
Message-ID: <87jzqt9sz5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Nov 07, 2023 at 07:33:37PM +0000, Alex Benn=C3=A9e wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > Fedora is gradually killing off i386 packages in its repos, via a
>> > death-by-1000-cuts process. Thus Debian looks like a better long
>> > term bit for i686 build testing. It has the added advantage that
>> > we can generate it via lcitool too.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>=20
>> Queued to for-8.2/random-fixes, thanks.
>
> Please tweak  s/bit/bet/ on the 3rd line of the commit message.

done.

>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

