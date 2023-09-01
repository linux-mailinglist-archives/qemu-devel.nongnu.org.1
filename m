Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 770A3790273
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:25:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc9k0-0005DN-JK; Fri, 01 Sep 2023 15:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coltonlewis@google.com>)
 id 1qc9ju-0005BY-Rr
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:23:31 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coltonlewis@google.com>)
 id 1qc9jq-0001xa-RJ
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:23:29 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34cacab5e34so8051425ab.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693596204; x=1694201004; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jk8eU1YUzlGph2kkfy1NgH1ax2sGgPgvKzoaDKemgb4=;
 b=oXYkIXYDziSUWq9BrI+1q/q3PyIoPbqLpoJcQ0T+iHUZ62Rh0mVch+W/KKrKPW0YSk
 Uyb0uoPe8JQeSts47aBw93gKdC9AN5n3PbLBFgOGkPRJApzdikjtsWiaWBdxudh32IP0
 GYSaDGabzgO8SWz5Y/bm8TTADOkW/RdLdsYZhLVVEzd5ZeB+QKcjSj7Civ5pL7PBzK1X
 Vvq8NXaWuKot6Oon7+2ESPVQo8jvLxUFfKklkQT7Kw7pe15LatOTGg+NXu8kQlbeYQmQ
 Y5qiJGgTzA8teDOmjmzZKm4VhwBzS237Ri97bpIVup7o8HrVgn83nZuekUHvg0lgFqyY
 //VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693596204; x=1694201004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jk8eU1YUzlGph2kkfy1NgH1ax2sGgPgvKzoaDKemgb4=;
 b=QvAiswtPgmzN5Oj4bBWdAnI+FKFFC9o7vtrjHfYnogUMi+TvQ6KqHRv+017CaANJI9
 FEXYi9gt9CYJ7ujbWJYZjdcDyXlOV+9tlTETO24TEEL58PSMcv/7UMdcpx2m7qlv9wYt
 r9jQ9DeqNOZDPtiDc+cfiwQSzbspBqfV6JafQkyvE7HOoh8IHHlhsMP4A+RB1mENypDZ
 OZuYLpbxEKCMn0NzVMR3sQIDhJP0blfha/ZDNgRbWsSFMbt9qWv0Idyl8mag5TilHgm0
 xa12tD83OOClmYwm10Imiw8NUQAjHC8gqLhT1UwR78fHMsW8Ou9yYkn7Xa4OCRHMMnfo
 w67A==
X-Gm-Message-State: AOJu0YzCxdNgJ9T0RJNyUM2rE4DVCeElf3VRUlm4dm4oQbiA7Kz/2bqk
 bvmuwHQ42Z5PJzjAqwx6y8JCIA==
X-Google-Smtp-Source: AGHT+IHARIbykt4ZHFf2A2z7AfZBgjkaI7ulhwMgGHyetk3eR9KVbd5UJppbxfa1hzIpHvaB8/atjw==
X-Received: by 2002:a92:d284:0:b0:349:3c0:395d with SMTP id
 p4-20020a92d284000000b0034903c0395dmr3617488ilp.1.1693596203704; 
 Fri, 01 Sep 2023 12:23:23 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com.
 [34.135.64.30]) by smtp.gmail.com with ESMTPSA id
 v12-20020a92d24c000000b00345d6e8ded4sm1252896ilg.25.2023.09.01.12.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:23:23 -0700 (PDT)
Date: Fri, 1 Sep 2023 19:23:20 +0000
From: Colton Lewis <coltonlewis@google.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] arm64: Restore trapless ptimer access
Message-ID: <ZPI6KNqGGTxxHhCh@google.com>
References: <20230831190052.129045-1-coltonlewis@google.com>
 <20230901-16232ff17690fc32a0feb5df@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901-16232ff17690fc32a0feb5df@orel>
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=coltonlewis@google.com; helo=mail-il1-x134.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Sep 01, 2023 at 09:35:47AM +0200, Andrew Jones wrote:
> On Thu, Aug 31, 2023 at 07:00:52PM +0000, Colton Lewis wrote:
> > Due to recent KVM changes, QEMU is setting a ptimer offset resulting
> > in unintended trap and emulate access and a consequent performance
> > hit. Filter out the PTIMER_CNT register to restore trapless ptimer
> > access.
> >
> > Quoting Andrew Jones:
> >
> > Simply reading the CNT register and writing back the same value is
> > enough to set an offset, since the timer will have certainly moved
> > past whatever value was read by the time it's written.  QEMU
> > frequently saves and restores all registers in the get-reg-list array,
> > unless they've been explicitly filtered out (with Linux commit
> > 680232a94c12, KVM_REG_ARM_PTIMER_CNT is now in the array). So, to
> > restore trapless ptimer accesses, we need a QEMU patch to filter out
> > the register.
> >
> > See
> > https://lore.kernel.org/kvmarm/gsntttsonus5.fsf@coltonlewis-kvm.c.googlers.com/T/#m0770023762a821db2a3f0dd0a7dc6aa54e0d0da9
>
> The link can be shorter with
>
> https://lore.kernel.org/all/20230823200408.1214332-1-coltonlewis@google.com/

I will keep that in mind next time.

> > for additional context.
> >
> > Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
>
> Thanks for the testing and posting, Colton. Please add your s-o-b and a
> Tested-by tag as well.

Assuming it is sufficient to add here instead of reposting the whole patch:

Signed-off-by: Colton Lewis <coltonlewis@google.com>
Tested-by: Colton Lewis <coltonlewis@google.com>

> > ---
> >  target/arm/kvm64.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index 4d904a1d11..2dd46e0a99 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -672,6 +672,7 @@ typedef struct CPRegStateLevel {
> >   */
> >  static const CPRegStateLevel non_runtime_cpregs[] = {
> >      { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
> > +    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
> >  };
> >
> >  int kvm_arm_cpreg_level(uint64_t regidx)
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >

