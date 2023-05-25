Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA530711878
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 22:52:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Hv9-0004lt-JW; Thu, 25 May 2023 16:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q2Hv7-0004lP-CS
 for qemu-devel@nongnu.org; Thu, 25 May 2023 16:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q2Hv5-0004R2-Ob
 for qemu-devel@nongnu.org; Thu, 25 May 2023 16:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685047846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHqXfjCA9vUpz6VNXpSdzwsB2+nlHguZuLyy+OMnr30=;
 b=EfgpCYBSQ6mOzdyphD8JWFnzdRJqtDcWeVsFMcNevl6Kme4ePn7LAbmUOn+kSpbdNXgqsK
 +rVlMNAM3uuqzziF2/kXdaDgFnSsRa9+ygZWyV7+II4bfYFw8Fr5iEAflsbZd2ixwm1YJA
 sFRGzLEAYjnswVPTdrkmelEPwmp9zaU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-FeAJU5fONaieq9RRgy_FSQ-1; Thu, 25 May 2023 16:50:44 -0400
X-MC-Unique: FeAJU5fONaieq9RRgy_FSQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1ae438721e2so96365ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 13:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685047843; x=1687639843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHqXfjCA9vUpz6VNXpSdzwsB2+nlHguZuLyy+OMnr30=;
 b=dZ4AX81CisYMfSI6tw9zpNNEcbbvFag741YUxb+OEfH5JSeR+tQy4efB8KSMykAebf
 jRv5ng2wmkK7e/9/5SloLpRUo3zAwExBebS8XwXZLicV5T2LDjN1HI6GHtT4QJA3npnY
 nMazJycuvbQrge4izDrnA/tEHi4IKQAdmVIRCLB3yQ2xOpxN4yzQ8QFG4mBEFjHxqTFo
 lo5Obhk65WOwz0N0pLpaVUNWI7hqpYknHULiwKAjqv/+mXND13XukECdUK6qALcgPirT
 8aSBd4jQOzcmegDvHopfVbEqENyi3yn8+ArcYcmnBncsBJjoIk7Rk6wG8+dEjOxCveva
 t8Kw==
X-Gm-Message-State: AC+VfDyFmEJgBF7jCDC1GmFNfBrtpu1aKsqdycRdCQo9Sc42HHka5wmK
 U1kVmJGfC4hpmwfFYAarQ0EBGDaAJFoOH16qtSbji1wqoYy/6ja/BKgXu3tks7TBQ2z6/VykLUO
 UJQnf18Cyrp9Ujy8wCxLVvxNwVT/cX/RPj9E9V8B4gA==
X-Received: by 2002:a17:903:18e:b0:1ae:dadc:ca2a with SMTP id
 z14-20020a170903018e00b001aedadcca2amr2823686plg.57.1685047843363; 
 Thu, 25 May 2023 13:50:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59/m28wk53+Ly0vU6Ic33xF7FrASsK1urcbLToTvGTtgpEG7MnF5u2+GyrdRUqokH3yz5p2M5KbFp1qF5kYp4=
X-Received: by 2002:a17:903:18e:b0:1ae:dadc:ca2a with SMTP id
 z14-20020a170903018e00b001aedadcca2amr2823676plg.57.1685047843103; Thu, 25
 May 2023 13:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230519082454.1102010-1-pbonzini@redhat.com>
In-Reply-To: <20230519082454.1102010-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 25 May 2023 16:50:31 -0400
Message-ID: <CAFn=p-aU8O+o21_TNX8v7Nd83XNsSiK3U8Zy6vHSrg2=a7RUFg@mail.gmail.com>
Subject: Re: [PATCH] mkvenv: pass first missing package to diagnose()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, May 19, 2023 at 4:25=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> If sphinx is present but the theme is not, mkvenv will print an
> inaccurate diagnostic:
>
> ERROR: Could not find a version that satisfies the requirement sphinx-rtd=
-theme>=3D0.5.0 (from versions: none)
> ERROR: No matching distribution found for sphinx-rtd-theme>=3D0.5.0
>
> 'sphinx>=3D1.6.0' not found:
>  =E2=80=A2 Python package 'sphinx' version '5.3.0' was found, but isn't s=
uitable.
>  =E2=80=A2 mkvenv was configured to operate offline and did not check PyP=
I.
>
> Instead, ignore the packages that were found to be present, and report
> an error based on the first absent package.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Late to the party, but ACK.


