Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D777280A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:41:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT1Ob-0006nh-M3; Mon, 07 Aug 2023 10:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qT1OX-0006nJ-MI
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qT1OV-0002Je-MM
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691419178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8q58zENzRplPYFjpsEGCaZKCxEZcaw6HyHg5ut0bO+8=;
 b=JtVVCTZ0arwCk6fyl2hSO582Efv8IqIgMoSskxD9/c9qPKE+m8ahzQU/WbNFwdFwlrGuNh
 ydM76LNa8QLg29gEDn/VPQUmM+IgdP3LeNfMXS+b5Fsg8ZDoT0+n0EI8Wtcxd80KVs9mUE
 fjIyObwpCmM298401G4ev3z84aNQbmg=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-rQBUmRHqM4yXe_IwtlEQcg-1; Mon, 07 Aug 2023 10:39:37 -0400
X-MC-Unique: rQBUmRHqM4yXe_IwtlEQcg-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-78681dff350so609081241.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691419176; x=1692023976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8q58zENzRplPYFjpsEGCaZKCxEZcaw6HyHg5ut0bO+8=;
 b=BNJsxyu0L8Zm3q2a48nQNPSPv6eLzw6z/LZbQ65RelOrBfWwtS6kKj/KRNYo9ZKYWB
 CRmSxUMec2wSEU5ZMGxm9MYn+o2aOwzIiYTuBPMCphAYReFhyxpialNHIepb4QJTXPd5
 g03/4+T8++RSwENkQ8wD9zQbPMNdmiEzwwFqoZ8qOV6XZHvUTbx3rpTlIm0T7cR7pCTz
 0GaTjJNsyjfMOhK6IUvV79/uTUZbJcQcbwvJseWtYBruwamyFdXqt9WUuvAKgpFm2wMK
 8RZ1T9nJRuNubYEQQRAUcg8vxHzD34cdnfHxRKRyOIGpkT9XPxa6pyvU29WFe7jPKf/P
 dluw==
X-Gm-Message-State: AOJu0YzFqM03532OTmRWjH7KzeN8ilKFnuc3wFy3YD+kz+AN1cgKsrhL
 WPopgFX9J/eQYuyex4quvEBWFd0LY/r8snHz2VL1CDmIoWlC4yYX1IZqpVZ13lu5w26A4HimjLU
 iR7nVzjIz+mmzMqESGtTzRzysTEROxBE=
X-Received: by 2002:a05:6102:d8:b0:445:bd3:5b3a with SMTP id
 u24-20020a05610200d800b004450bd35b3amr4327813vsp.4.1691419176735; 
 Mon, 07 Aug 2023 07:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAoqmekQjL6LcveAesu+d+XHzqEJHOCjVNazZsgmaIrIs7rKXBnOKEvzlyMyJII1BdhHOhFdL7LLekfb/m47M=
X-Received: by 2002:a05:6102:d8:b0:445:bd3:5b3a with SMTP id
 u24-20020a05610200d800b004450bd35b3amr4327801vsp.4.1691419176422; Mon, 07 Aug
 2023 07:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230807094807.471646-1-pbonzini@redhat.com>
 <20230807094807.471646-4-pbonzini@redhat.com>
 <CAFEAcA8mR04aAQcuB4d0L6XkEPNGfF2+QRg2FVPT3feBVst-7w@mail.gmail.com>
In-Reply-To: <CAFEAcA8mR04aAQcuB4d0L6XkEPNGfF2+QRg2FVPT3feBVst-7w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 7 Aug 2023 16:39:24 +0200
Message-ID: <CABgObfYhz7Sz6x31ZDvoQCxdRbfUA7-ab9VCE83run+S=A3-XQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] configure: unify case statements for CPU
 canonicalization
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Joel Stanley <joel@jms.id.au>
Content-Type: multipart/alternative; boundary="0000000000002d668e060256378a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002d668e060256378a
Content-Type: text/plain; charset="UTF-8"

Il lun 7 ago 2023, 15:45 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> Can we be consistent within this case statement about whether
> the ';;' is on its own line or at the end of the last line of
> the case ? We are not fully consistent within the entire
> configure script, but mostly we put it on a line of its
> own. (I prefer that personally.)
>

Yes, especially given the nicer diffs.

Paolo


> thanks
> -- PMM
>
>

--0000000000002d668e060256378a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 7 ago 2023, 15:45 Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Can we be consistent within this=
 case statement about whether<br>
the &#39;;;&#39; is on its own line or at the end of the last line of<br>
the case ? We are not fully consistent within the entire<br>
configure script, but mostly we put it on a line of its<br>
own. (I prefer that personally.)<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Yes, especially given the nicer diffs.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--0000000000002d668e060256378a--


