Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8178A735414
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 12:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBCUD-00059V-St; Mon, 19 Jun 2023 06:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBCUA-00058a-SA
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:51:50 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBCU9-00069v-2n
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:51:50 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51a324beca6so4635877a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687171907; x=1689763907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NzeOQqm6bMSH4mmgZgIqSWTWkGzqi873UyO1dzFYfJw=;
 b=zUIn5DYwTse08kTz8WdCdV2etI9/44Gsfauc2G7JwbRdslVziZgCV/TwQSFzT4ruuL
 07OOnys6bkOTkBkR4I7f9iqO4utIknCnKXVss/RNJSL7H0rZGYgOYJ4/e8KLlisCqOLt
 ABcx9CZtvVRuLx2WRzEqT8EYaNPmqHJxhXoAoamHJtyoaHZvqbZ4pn9H2tUBmJQ+VvBF
 et9snbINgP0mMlJnaZFnI+TO8qqJAXOaH4DPeUYdmdH1OKtZj4CJMdLjr/Z78VCQVGfs
 znVWHTRd6+e6aql2KE7cxBO1gFOfV+PgpgYt1gq6As4rxnYPwZ4ig0ywr2DSizIntJvg
 RdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687171907; x=1689763907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NzeOQqm6bMSH4mmgZgIqSWTWkGzqi873UyO1dzFYfJw=;
 b=PvPOvDQa2bnllEEgf6i0tswi1yuna+oX+6lu+/iK4rv62+rIon7wmKr8Ko6ZESZpb6
 whc83CSMtDs42Kbh7tZ8MB2UW/6OMEH732s8bVXpWecj25JeURZnkMrP2XQMSVe2u52N
 kGXbZ6Ol7GYvm/WJadY6NKeeul4ZYVmlQ2ocKibR+Jw6fjqVF2u8stwf4a7k8p+LM3ln
 lX7R+hma6JuFWeP/uUMELRbWmZGTH2P0s+jOrhp/hH+vqK2zWH8yNXBMfoia31r3+L6H
 Cu7qcHpDP3jhZkL1PiL5M9c63CbMve8OZjyu7eMxew5zrugmIgzqVUiQ27jrBtHgsmVv
 aUaA==
X-Gm-Message-State: AC+VfDye6Ao+12/J6DKytDYzEhDWNcKOFn/4WrN2VHWPvs5oDygWeD6X
 zqIEAnCE51umQsa5b6LsQ17jBG3z2aV0Wplw0yZfPK48BkrwIpU2
X-Google-Smtp-Source: ACHHUZ6ML9XD4PlGOd+JB8ds9ln8X9H9YMOVLPdzSueI1xR02ukibsfSdas3hoRPQvCt0X/ZyMQvN2TCx+Fgy4xioEQ=
X-Received: by 2002:aa7:db8d:0:b0:514:9929:1b01 with SMTP id
 u13-20020aa7db8d000000b0051499291b01mr5854201edt.8.1687171907432; Mon, 19 Jun
 2023 03:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
 <20230609172324.982888-2-aaron@os.amperecomputing.com>
 <a8db353d-b258-c856-d5ce-1236b0893a53@linaro.org>
 <ZIcbF8zShOr1N2Sl@strawberry.localdomain>
In-Reply-To: <ZIcbF8zShOr1N2Sl@strawberry.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 11:51:36 +0100
Message-ID: <CAFEAcA8pjgXXnUcLxcnm-9mcakps4KcXKOvHQxzj7n_CzY2zSA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] target/arm: Add ID_AA64ISAR2_EL1
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Vincent Dehors <vincent.dehors@smile.fr>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 12 Jun 2023 at 14:18, Aaron Lindsay
<aaron@os.amperecomputing.com> wrote:
>
> On Jun 09 13:49, Richard Henderson wrote:
> > On 6/9/23 10:23, Aaron Lindsay wrote:
> > > --- a/target/arm/hvf/hvf.c
> > > +++ b/target/arm/hvf/hvf.c
> > > @@ -847,6 +847,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> > >           { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
> > >           { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.id_aa64isar0 },
> > >           { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.id_aa64isar1 },
> > > +        { HV_SYS_REG_ID_AA64ISAR2_EL1, &host_isar.id_aa64isar2 },
> >
> > Sadly not defined for MacOSX13.1.sdk, and it's an enum so you can't #ifdef it either.
> >
> > You'll need a meson probe for it.
>
> I'm not very familiar with HVF or meson - I am not sure I understand
> what you're suggesting here (and a few attempts to grep around for an
> example didn't turn up anything that looked helpful). Are you suggesting
> some sort of build-time auto-detection, a "dumb" configuration switch
> that a user could use to manually enable this, or something else? And/or
> is there an example you could point me to of what you're thinking?

So the first thing here is: where is HV_SYS_REG_ID_AA64ISAR2_EL1
defined in the first place?
https://developer.apple.com/documentation/hypervisor/hv_sys_reg_t
does not list it.

If this is really the right name for the value, then:

We do our build-time detection of stuff that might or might
not be present using meson's facilities or that kind of
thing. These are all in meson.build. In this case I think
that what you want to use is has_header_symbol(), which
checks for presence of some symbol in a given header. There's
examples in meson.build, you want something like

config_host_data.set('HAVE_HV_SYS_REG_ID_AA64ISAR2_EL1',
                     cc.has_header_symbol('whatever.h',
'HV_SYS_REG_ID_AA64ISAR2_EL1'))

which tells meson "if this header has this symbol then define
this preprocessor value HAVE_...". Then you can #ifdef on that.
(We're inconsistent about whether we use CONFIG_FOO or HAVE_FOO
for this sort of test.)

Or alternatively, since this is macos specific and Apple are
quite careful about API versioning, it may be simpler to use
macos's own version macros to ifdef things so we only try to
use the enum value when building for a macos version that knows
about it. Grepping for 'MAC_OS_VERSION' brings up examples of
that approach.

thanks
-- PMM

