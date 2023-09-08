Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A24FA79851C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYCE-0006E3-U7; Fri, 08 Sep 2023 05:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeYCC-0006De-P7
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:54:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeYCA-000527-2n
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:54:36 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31ad779e6b3so1768989f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694166872; x=1694771672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTSKqQ5DcE2RR66cknE43+Cwuq9Px+PamUjoyLdTrFQ=;
 b=ic64oDIH9sx2lLVwH77mLJ56Q205vLbRlEwQKgDM+mfZfcz4BQJR7aAynLWCiYvg2+
 FgU56TzxdU0FwVoenHbe24unvgMopCrifVcNy1B8M+FlKMhgmOoiArL8HQSliTPGJJpD
 osl+Ysl92+sx70XzICqkDafhhvh8vlm0yujjioAGBP0YDFedsB8EZ/LqwJ0D6wwbQ44d
 9YBCFofGZLAIRvd0EOzJ9FZ1I7gKYTx+ZCi4tMhL9NkjNtAK8L2fEB92UPvMtLMCGdgh
 7nAdc08yncOy1+83DXmSwCx45ld6zo/g00rdIIQtQ+6DCdf9+Jukhk2C/vbBJyRTcTS8
 hOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694166872; x=1694771672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTSKqQ5DcE2RR66cknE43+Cwuq9Px+PamUjoyLdTrFQ=;
 b=IykLN4V86dE4u/vA1gkh/WzOTAfwIfLSJyupGdFAHAhPbI0KNz6k7s31BfKoAvpSy6
 undzddgcOLQbjBUq45vftMisFIJHFriW2pGOtCiDG56kX7qJ1Gvzi8xCqaa8Ih9l2Au6
 BxKeJfqWs2skm0xvtVIV5b9zuCw8Vr05Q+lXc3075dSOH232xDjc0Cbi53cEj8qce0ys
 P9CrFJKLV6rIalSbWnfqr4iIpYCQuqjV9kvVpbTILmomQqYNGudKr0MtTwxZymJPB2Lh
 6CxMVqYum4rCx4UPWgzx2ZBPyN/ZJBwjCD2T9QulLACXt3aLebHN/lwis9c0Gu/HAhjb
 m7nw==
X-Gm-Message-State: AOJu0YypAUURJCHkx7yBOuwG6CPl8D28e/D02lvulyeemF7PQlRS4+9A
 Po8CwfUgDnbHpXwKYZZJUAVNIrRSftcWLldJyuKXrQ==
X-Google-Smtp-Source: AGHT+IEBdbnloCvm9Ba0OGFZxzrV0rHioPFE3UdFfaJaiWmvoOzDGY2yIBbWq/1Y9GgCTHDf+byO2tp0ZZ/lJZfANsE=
X-Received: by 2002:a5d:50c5:0:b0:319:8436:d77d with SMTP id
 f5-20020a5d50c5000000b003198436d77dmr1386711wrt.37.1694166872371; Fri, 08 Sep
 2023 02:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230904162544.2388037-1-berrange@redhat.com>
 <ZPbt0io6He9mE2SB@redhat.com> <87edja9vkr.fsf@pond.sub.org>
 <CAFEAcA-OVUqhwUprR2MJW24yxWpvz9zxv7u7iGqnYhtaGNM96w@mail.gmail.com>
 <ZProov27HNpHmz5j@redhat.com>
In-Reply-To: <ZProov27HNpHmz5j@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 10:53:56 +0100
Message-ID: <CAFEAcA9sKeUmVvzPoQGCZc_GJa8vUbp58T9VnQ3F+P+Zhht9QQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, William Tsai <williamtsai1111@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 8 Sept 2023 at 10:26, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 07.09.2023 um 11:35 hat Peter Maydell geschrieben:
> > On Thu, 7 Sept 2023 at 10:33, Markus Armbruster <armbru@redhat.com> wro=
te:
> > >
> > > Kevin Wolf <kwolf@redhat.com> writes:
> > >
> > > > Am 04.09.2023 um 18:25 hat Daniel P. Berrang=C3=A9 geschrieben:
> > > >> By the time of the 8.2.0 release, it will have been 2 years and 6
> > > >> releases since we accidentally broke setting of array properties
> > > >> for user creatable devices:
> > > >>
> > > >>   https://gitlab.com/qemu-project/qemu/-/issues/1090
> > > >
> > > > Oh, nice!
> > >
> > > Nice?  *Awesome*!
> > >
> > > > Well, maybe that sounds a bit wrong, but the syntax that was broken=
 was
> > > > problematic and more of a hack,
> > >
> > > A monstrosity, in my opinion.  I tried to strangle it in the crib, bu=
t
> > > its guardians wouldn't let me.  Can dig up references for the morbidl=
y
> > > curious.
> >
> > I don't care about the syntax on the command line much (AFAIK that's
> > just the rocker device). But the actual feature is used more widely
> > within QEMU itself for devices created in C code, which is what it
> > was intended for. If you want to get rid of it you need to provide
> > an adequate replacement.
>
> I have a patch to use QList (i.e. JSON lists) that seems to work for the
> rocker case. Now I need to find and update all of those internal
> callers. Should grepping for '"len-' find all instances that need to be
> changed or are you aware of other ways to access the feature?

AFAIK the only way to use the feature is to set the len-foo and
then foo[0], foo[1], ... properties, using any of the usual APIs.
So git grep '\<len-[^-]' should find them all.

If you want a cross-check, the devices that use it are easy
to find (search for DEFINE_PROP_ARRAY), and almost all of them
picked property names that are easy to grep for.

But as Daniel says, if you haven't changed the behaviour for
"code sets the properties in the right order" they may not
need updating.

(I would be happy to see the rather hacky implementation replaced
with true support for list properties at the qom/qdev level.
But the hack is there because it was simpler :-))

thanks
-- PMM

