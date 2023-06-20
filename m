Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B8737180
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBeD5-0007iX-8H; Tue, 20 Jun 2023 12:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBeD3-0007gt-1E
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBeD1-00074n-8N
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687278477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4B2OmaAy43UlM2+L2Qtzjku2eW6xxLNi6X0cM1WTJA=;
 b=GZFp4Zly/1vIBMdVyX7XrVjhdbOV/u0ZrIUegKd026uyrM57qDaQGLAjg47SQ5ySBtnUzH
 Yrhph/09iD3/RiGQ4VbhU1pNmBW6CFxx7ro6I3DlknMnkiCMoJKWioNJdSJawuMDpl8dhu
 8p768BALDO8VKeUK/JoxKjkv6zrqAGw=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-rO1BG8gSPJKGOXyyn56Ajg-1; Tue, 20 Jun 2023 12:27:48 -0400
X-MC-Unique: rO1BG8gSPJKGOXyyn56Ajg-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-440cb3204feso137586137.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687278460; x=1689870460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4B2OmaAy43UlM2+L2Qtzjku2eW6xxLNi6X0cM1WTJA=;
 b=QwFoRVUQ/v2ZZA58tux5VS/jMN7gLN4/+gcbpD8Yrdsd6j7yYQyU7Kvalaw3t6sP31
 A1pA50Kmj+HGhVjVtcSDqR111uAowx35PaVNRU9MxJdQF5ofNs6xAnoKORnuoZ4Rtnu7
 DUIUnnLRq4TFedHGeju94vzF3v5w4TG/dIo2kzGBXyPIy8MxmsBsu4ASwEKeNhJb/CDT
 KJ7odBTrDJN7q7Umnl3aLMti2VpQ+o95NHAq4JsyjdSd3za8DHF4NVWl86oA8UiNaNN+
 be1xAL+dzuUOBixThMYwY2leyvGpH1vflqc/xO/rdRyTn95GzF0yBcjSUCA/9he3ERW2
 5j+Q==
X-Gm-Message-State: AC+VfDxhPYXeJ1G/NW6TDyUiWc72HUBHo4np9/aIp1iikCtgVXMjB1V8
 tc0nfSm3ikRpdnY76FLPCmKZzhQzMmRXNpN841cQcM9OekmtWQOWEeXQZ712jQcBis3EXMc86R2
 UnlIYideKdxqRwBjSAc4Iedn0+r69i4Y=
X-Received: by 2002:a67:f746:0:b0:43c:d5c5:2736 with SMTP id
 w6-20020a67f746000000b0043cd5c52736mr3834997vso.31.1687278460479; 
 Tue, 20 Jun 2023 09:27:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Fnubq+5bZSr5+55NYsQO4Zt6NNX9ZxdiQ/UvXnw4/tPvial3/Hd5ct2sDhbXlsvgI71/WH5BpiEBmaLIPQ2A=
X-Received: by 2002:a67:f746:0:b0:43c:d5c5:2736 with SMTP id
 w6-20020a67f746000000b0043cd5c52736mr3834985vso.31.1687278460150; Tue, 20 Jun
 2023 09:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230620151634.21053-1-pbonzini@redhat.com>
 <20230620151634.21053-10-pbonzini@redhat.com>
 <80401c46-0d52-a538-04e7-d860795d83e9@linaro.org>
In-Reply-To: <80401c46-0d52-a538-04e7-d860795d83e9@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 Jun 2023 18:27:29 +0200
Message-ID: <CABgObfbeJ8E3jkgc7D6Q7ci-m=iLycK96B7KvRVNFcpJ02x9Jw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] target/i386: implement 32-bit SYSENTER for
 linux-user
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jun 20, 2023 at 6:23=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/20/23 17:16, Paolo Bonzini wrote:
> > TCG reports the SEP feature (SYSENTER/SYSEXIT) in user mode emulation,
> > but does not plumb it into the linux-user run loop.  Split the helper i=
nto
> > system emulation and user-mode emulation cases and implement the latter=
.
>
> I'm not keen on this.
>
> This belongs with the rest of the vdso (see patches posted years ago; com=
mitting binary
> blobs rejected, still waiting on a decent way to invoke cross-compilers t=
o build them).

As we discussed in Dublin, that should be doable by reusing the
tests/tcg logic in configure (though we would likely commit the binary
blobs as well). You could do it in your sleep. ;)

> Further, this shouldn't ever be reachable, because AT_SYSINFO won't be pr=
esent to give the
> guest libc the location of the vdso routine to call.

Even without AT_SYSINFO the program should be able to do SYSENTER and
'trust" the kernel not to change the epilog of the routine.

To be honest I don't like it particularly either; but I also didn't
like that SEP is reported but doesn't work (and the purpose of these
patches is to allow using named CPU models in linux-user)... I can
certainly drop the patch since it's been like this for ages.

Paolo


