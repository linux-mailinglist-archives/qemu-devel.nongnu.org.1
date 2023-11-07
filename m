Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D26517E493A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:34:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RpX-0000U3-Bk; Tue, 07 Nov 2023 14:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0RpV-0000Rk-AR
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:33:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0RpT-0001jP-OC
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:33:41 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so52141495e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 11:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699385618; x=1699990418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcBJC8cr8EqZCzquMEoFpjs04JKyUY+tdsarDV1mRl8=;
 b=CN0+Azhzecb4ZYbhC5RMIvcDY/TmruFRej3Pus6X2kSqMzHmVoqpawWm8JZ/mB806x
 7b9ipNjDv4Dka35JusDlA2U2htqCM2v8wHoGQMvlJJyDeBrd7Ud+idxv/czTIHheEcJj
 gYq1r/65vaW6u7+011n1FbvVcZQkL+RsfJ/s44HdKVe0AN81NrROJfqUXjDjn9TArfzt
 rB6IKwQEtlNuUsi4pMNjWGiuUDVNov750uqcVAQ2y/xLHfGKaYBHBv1RB5vR5SZ5AgDo
 +MnvdISUewAphCICJ2cQuZWDRtQfbhYpSR+tE3xzTuUwnDfrl7j7OxWm4Awl+qPF2ZY3
 0gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699385618; x=1699990418;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DcBJC8cr8EqZCzquMEoFpjs04JKyUY+tdsarDV1mRl8=;
 b=pxBxccBoPORmX1N8fZq5mijrsAgvCrHBct3op54appMHBsK1dga6DuiWDO/MK7JZ9D
 Jtzbog/OO/bb0Oii3MjPavZBc7/I3zszbrXbEAVmjJ4m0HrZS0ND0cWHvMAvUo9wAlsT
 9arV0+1ssmgkFLCMeupxg0HyD8pzKCUAwclkV3a0J1uZnVdYDtFchwxn2xTPhL08zo9U
 peSz7TQyx2kJdYbwYa26sEiR+D1TYoa8H7J/slv34lEgKj1Z8pIFYt/+ZN5yeztRK6xh
 hV5QkyjYgmXhiDT26coZTNcDe3q3xRZpahTSFaP0fx9TdsXsWD0kFa8+LTOJTlnvrgtL
 qFNQ==
X-Gm-Message-State: AOJu0YxAWWp/7Sn6gI2MDO67N3bn3afwD9dmNZOXsidrlKlp3yW/C5hj
 OAAVp6iJTSjKsoFkhp4+aJCbSw==
X-Google-Smtp-Source: AGHT+IH49tDqzDWfRDyg1bxwZf83PpxCbfLUmIJ4ROSmE845QGQhDiOsVm/yk6UirgiU35WZTvs6TA==
X-Received: by 2002:a05:600c:3145:b0:40a:206a:578d with SMTP id
 h5-20020a05600c314500b0040a206a578dmr3114398wmo.31.1699385618042; 
 Tue, 07 Nov 2023 11:33:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c198e00b00405d9a950a2sm16894484wmq.28.2023.11.07.11.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:33:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 616B85F792;
 Tue,  7 Nov 2023 19:33:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Beraldo Leal <bleal@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/docker: replace fedora-i386 with debian-i686
In-Reply-To: <20231107164109.1449014-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 7 Nov 2023 16:41:09 +0000
 (2 hours, 52 minutes, 11 seconds ago)")
References: <20231107164109.1449014-1-berrange@redhat.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Tue, 07 Nov 2023 19:33:37 +0000
Message-ID: <87v8ad9x4e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

> Fedora is gradually killing off i386 packages in its repos, via a
> death-by-1000-cuts process. Thus Debian looks like a better long
> term bit for i686 build testing. It has the added advantage that
> we can generate it via lcitool too.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Queued to for-8.2/random-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

