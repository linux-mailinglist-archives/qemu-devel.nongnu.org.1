Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A27989C1
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 17:20:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qedGK-0004iK-Mm; Fri, 08 Sep 2023 11:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qedGI-0004hj-J3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:19:10 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qedGF-0003Cf-VL
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:19:10 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4bdso2870617a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694186346; x=1694791146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oZQ6qtvFrPqdzPNgmbPFsuLVuk8QYhuQ7JQ9mo+GFsk=;
 b=mv9sJic/ayjNbgbEGDZ68zzOwgWcK7Rfg3ucUUGCGbxXgAAl2Yg2NL1Xr3w+R0ObWB
 +3/EBmzgwYIv93sQZlXtTKTpvbJRittEyYPKy2V3W7gUFmIcJleIwhwgIe2Ne3ygWZPd
 0kUVD1axBREiGdjNXo8rHtCrzpBrQsay12Ia15FqnPeXvRJCJNNTuMvlrShfslF8Ufup
 i0eGgKgEIASKAftCqKGWMFNnEtXj6swTlnBOuhhFqPskWDtkg2hnHw/Wi4L5agu+P7Ms
 8LpmShs4BDR2wYLTjQZKE9NaGMRdTZzcix0a4/E89BDfXQrr0lc7o+g+YLcr0xAsysa5
 5New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694186346; x=1694791146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oZQ6qtvFrPqdzPNgmbPFsuLVuk8QYhuQ7JQ9mo+GFsk=;
 b=L8YoqyN4ZSB4NTEWig5RNNG+Dl7UcaVk+HO4R7d4cI8AuJwLa4KbgKr2FYLayTLaWZ
 2waTeD4RVyuBDNopjxrmYfnxa8wNR83f1BxSKe5VdVMPgLuBM3V5YKy1gWaAeoY26Vc2
 zUT+KZ9cMYuol1hSubZRd8BqZHFRHV6Hx5MQKwTAhZQtbsdaMa0glfDuPOAw0xeWhL8j
 N5xMMnzjnKx/kA3zs4Ja1J2UtZ0eZxA9/dCG0g27A0v+CeAI6x5vAldyQy+Xu+IE3cYd
 JndcZx7IEn5+cAKzNrDfUIVmtxgXO34qteRDoDdDnb+bAa+krXT3mq2MDB+EIDv9j2OZ
 +pbA==
X-Gm-Message-State: AOJu0YzXM6NgrZvOTQujVY2yT3/CIY1cvBBK4AHYEVbRQlqi/1/sDNVg
 x+26If5eniWxQ17eozmfrpvs1nuNNG/BJdGBEqWgpQ==
X-Google-Smtp-Source: AGHT+IFoIbqexplnnRL3eeFia4PBetA+kr5jTjzIca8vnZMcR9LV3+KswNQ6NEaHNt1LbJXXNePaVVj/30glJAguwns=
X-Received: by 2002:aa7:c2d7:0:b0:524:5e4c:2fa4 with SMTP id
 m23-20020aa7c2d7000000b005245e4c2fa4mr2142377edp.14.1694186345961; Fri, 08
 Sep 2023 08:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-12-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-12-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 16:18:55 +0100
Message-ID: <CAFEAcA9N3c1=Q-75iA-k4r-5FK0b3=yj+FtPFaj3Fg8aT4J3ZA@mail.gmail.com>
Subject: Re: [PATCH 11/11] qdev: Rework array properties based on list visitor
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Until now, array properties are actually implemented with a hack that
> uses multiple properties on the QOM level: a static "foo-len" property
> and after it is set, dynamically created "foo[i]" properties.
>
> In external interfaces (-device on the command line and device_add in
> QMP), this interface was broken by commit f3558b1b ('qdev: Base object
> creation on QDict rather than QemuOpts') because QDicts are unordered
> and therefore it could happen that QEMU tried to set the indexed
> properties before setting the length, which fails and effectively makes
> array properties inaccessible. In particular, this affects the 'ports'
> property of the 'rocker' device.
>
> This patch reworks the external interface so that instead of using a
> separate top-level property for the length and for each element, we use
> a single true array property that accepts a list value. In the external
> interfaces, this is naturally expressed as a JSON list and makes array
> properties accessible again.
>
> Creating an array property on the command line without using JSON format
> is currently not possible. This could be fixed by switching from
> QemuOpts to a keyval parser, which however requires consideration of the
> compatibility implications.

Could we have a specific example in the commit message of:

The old (currently broken) syntax for setting the ports
property on the rocker device is:
 -device rocker,len-ports=2,ports[0]=dev0,ports[1]=dev1
The new syntax that works as of this commit is:
 [whatever]

?

I would expect most users have no idea what the JSON list
syntax is.

thanks
-- PMM

