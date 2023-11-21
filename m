Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A37E87F2AEA
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:46:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5OGJ-0003dP-6h; Tue, 21 Nov 2023 05:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5OGE-0003cl-Jo
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:45:44 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5OFz-0003tA-HU
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:45:42 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-41cbf31da84so30646971cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700563526; x=1701168326; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srjcnsI3toWtE70GXDG5CQRKT63Jc+1CtO3e4gMxVTs=;
 b=LjoYgeQrXGd1yzJ9AqSAIoktMTmWs37pBpqmn2al8cYz4pO2oizQkWAsk/8kOD5lxL
 jbfpvpIJUuwLjDmPQZ1Nye/e+CsOowMvv1GExuzyhva51Nd4bLPBltcuqtPQPkCzENTB
 CJ5j/ofMAz2pDlPXkLC2WQeM7lAgIEK5QyeFAt15SER18GxdJ7z9015zskoT8zhP/hHQ
 odBRmf7HM1tZQKbML6L3+ua5u2cNvsTt7rxH5VYkonnHIFyExhLGubAJ0fvGaBQeQz4z
 U+lYNP4CYOZCVxokXysYA4f1bK9i2VRu5P8xYhkTk0e1ODbnhYzlTHc7KWLO11w8Zz+R
 IZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700563526; x=1701168326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srjcnsI3toWtE70GXDG5CQRKT63Jc+1CtO3e4gMxVTs=;
 b=jFLMFN3GPrBREA8oZh/YZDarPO6HEO1uozEWJ15Is1g13BNQcd+6Kxf23kvheExy2q
 azbuJuX2Y8//2PBa1tjlBVbgfMCOJByt0OnU2JxosGvLnCZq6cpF4ZoZy2WpkN1pTAn8
 9GTksZC77NJO1GaS+VpNM4bbnoYel3NzKoOp4mkJWgb2FwHbyxanyrPwZUB4MDcE73j9
 YGR8g5g96ZqHiNFRUvoSHtrv7fpH7x72DwVy9b4jTSPLXJ0Nf+pxWeSpGysIq+ESglp8
 SR9Y/r/TN7d0+WoB75h0/7Udck1ARv+FrrddCf6IR69tY23z6cY857A6/hplZXcV7eu5
 Dx+Q==
X-Gm-Message-State: AOJu0Yz6+1kSVH3YN4nTReIfeVZcjxh3PWV2lBajLjJUfgQedvyJgF0k
 ne6U4D7ljUFnjfUHm6mjfym5h+dIcCf3irMIlpk=
X-Google-Smtp-Source: AGHT+IGykzjJtZ/dBDSLmIjbOV2uIAIIN5nQ+Kd1ED1mDB3W8lmDnJ1S+/V2YYExNdY95I/rcMEd1Uc4MI2tLUUlESE=
X-Received: by 2002:a05:622a:14c9:b0:41c:e028:7254 with SMTP id
 u9-20020a05622a14c900b0041ce0287254mr12148793qtx.34.1700563526189; Tue, 21
 Nov 2023 02:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
 <CAJ+F1CL_a72vuH0ShLwVXKW-2sTzSX0LnWtSDT6BxKNx_ZUhzg@mail.gmail.com>
 <3c467e84bcbde020f9e3323de1abb69d78b552c9.camel@amazon.co.uk>
 <CAJ+F1CJes+QAeJOHMKH6_aa0JV14Dkj0WAM-QarQkqRgiZ0V7Q@mail.gmail.com>
 <cf5209ce4dfca6692bcc3daf66939bcc55001e4f.camel@infradead.org>
In-Reply-To: <cf5209ce4dfca6692bcc3daf66939bcc55001e4f.camel@infradead.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Nov 2023 14:45:15 +0400
Message-ID: <CAJ+F1CK=ieMpdA4fwSJ6AKkFhoQFGiQLCc_-QqE-5y4O==4X7A@mail.gmail.com>
Subject: Re: [PATCH for-8.2 0/3] UI: fix default VC regressions
To: David Woodhouse <dwmw2@infradead.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, 
 "gmaglione@gmail.com" <gmaglione@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, 
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi

On Tue, Nov 21, 2023 at 2:42=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Tue, 2023-11-21 at 14:37 +0400, Marc-Andr=C3=A9 Lureau wrote:
> >
> > Thanks for the quick test. I am bit reluctant to push your change in
> > 8.2 too. It's a change in behaviour at this point, not simply a fix.
> > But as the maintainer of Xen stuff, you have perhaps the final call.?
>
> it's not a change in behaviour yet. Being able to add xen-console
> devices on the command line at all is new in 8.2, so it only ends up
> being a "change" if we do it after the 8.2 release, which is why I'm
> keen to do it now.
>

I didn't realize that. Perhaps it's best to go through the Xen queue.
I already sent a PR for UI regressions, as we are close to rc1.

thanks!


--=20
Marc-Andr=C3=A9 Lureau

