Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1498735F5F
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 23:49:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBMij-0004Vz-Fg; Mon, 19 Jun 2023 17:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBMih-0004VR-Go
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 17:47:31 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBMif-0008Fb-JJ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 17:47:31 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f86dbce369so2369787e87.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687211247; x=1689803247;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19Y9XIm8UEoInXTpZOfRGOATsfiS/cxWaoyy8L1XKdM=;
 b=trhAQNc1G5mQcbO/umIZTp0vxhf2/PRJfX7Y1eB26cl2nXqeWmma1oVo6hvhh9Xmni
 p8XW6RlCd2NXUOjyjf7nbH6EEm+P8CvJbuHMDTWE9JlfnZqv7Vg797LjqaxaITKMxPHp
 T3KKhGKWdgL9hzHjdTcCNrYRDxTxrIjosFVMPF22w5xRVeM3oTkcBUiTCKeZFGETxa1J
 +Au07+rFLi5s2bdZv2i6Gq4vFzH5d7ja9mZpv6SHhHgNm9eBn7mft9PM+gckexPALd2X
 Wpe1kOK3FCyY4YkS3Tx86qjVi9i4Woin9ZdLbKcz6K5goXAtCBVWr06YZZYq8/y03Nx/
 f3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687211247; x=1689803247;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=19Y9XIm8UEoInXTpZOfRGOATsfiS/cxWaoyy8L1XKdM=;
 b=JbHRhDg6BcD0kXC07MkB3Lk0aY4sLclkeRKOP1D1Cfib78Iqolu9qFL5nKQd9KE6KR
 98Z5ltIYh57t6TwyUVW9sGSIHFiRnFxUG+yBSJfSLrVPrKfhaJEecoxce0xJNl8vCJ70
 PsY8iwciiMJRMtkzY/2v/mjdnSimq/AozreVSYMxBqKgchezjywf/8en623b0Pe/Bi37
 xy/7vxJgzqRTHn+eIsqok0W8+gomQdu5p7SkuyuxUCi/290vNkYp6mOQ2TKCsVh2rqWl
 02PdPgVL6weKnQqrfHHAiy6bUHIw7w2ghdhaWphcH4skxT9n1KzX91/0ft4HW9AZx21y
 lwHw==
X-Gm-Message-State: AC+VfDx9uV3j7wTBGKSSqOL31yU6sR0LIfp7/vN2xF7OaXPvauwpnZ6X
 u5NLnG4kr1URm+aPVb7VelZCdSeWwlu6lObOuRo=
X-Google-Smtp-Source: ACHHUZ7vrucbaOmDcVu3atJSbdvGUf8pQROKnJmWvywSvZ2IECB9/ttjR2NPXAG4MWhtgXXiEEpULQ==
X-Received: by 2002:ac2:5f9a:0:b0:4f8:631b:bf74 with SMTP id
 r26-20020ac25f9a000000b004f8631bbf74mr3212923lfe.38.1687211247511; 
 Mon, 19 Jun 2023 14:47:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y10-20020adfe6ca000000b0030fd23381ffsm531372wrm.11.2023.06.19.14.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 14:47:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8C0541FFBB;
 Mon, 19 Jun 2023 22:47:26 +0100 (BST)
References: <413144073.1734477.1687203818872@webmail-oxcs.networksolutionsemail.com>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "frankwmiller frankwmiller.net" <frankwmiller@frankwmiller.net>
Cc: qemu-devel@nongnu.org
Subject: Re: Faster than real-time execution
Date: Mon, 19 Jun 2023 22:44:34 +0100
In-reply-to: <413144073.1734477.1687203818872@webmail-oxcs.networksolutionsemail.com>
Message-ID: <87a5wvjf9t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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


"frankwmiller frankwmiller.net" <frankwmiller@frankwmiller.net> writes:

> Greetings,=20
>=20=20=20
> I've been contemplating using QEMU for faster-than-real-time execution of=
 SPARC executables on an X86-64 machine.
>   It appears from the base architecture of QEMU that this is not possible=
 if QEMU is using JIT of the SPARC to x86-84
> since the resulting x86-64 will run on the hardware at the processor cloc=
k speed and there's not really any way around
> that.=20
>=20=20=20
> However, is it possible to do something like this.  Execute the SPARC ins=
tructions in simulation, i.e. without any JIT, and
> then since everything is executed as simulated SPARC instructions, essent=
ially speed up time in the simulated
> environment and execute FRT that way?

Have a look at icount mode:

  -icount [shift=3DN|auto][,align=3Don|off][,sleep=3Don|off][,rr=3Drecord|r=
eplay,rrfile=3Dfilename[,rrsnapshot=3Dsnapshot]]

      Enable virtual instruction counter. The virtual cpu will execute one =
instruction every 2^N ns of virtual time. If auto is specified then the vir=
tual cpu speed will be automatically adjusted to keep virtual time within a=
 few seconds of real time.

      Note that while this option can give deterministic behavior, it does =
not provide cycle accurate emulation. Modern CPUs contain superscalar out o=
f order cores with complex cache hierarchies. The number of instructions ex=
ecuted often has little or no correlation with actual performance.

      When the virtual cpu is sleeping, the virtual time will advance at de=
fault speed unless sleep=3Don is specified. With sleep=3Don, the virtual ti=
me will jump to the next timer deadline instantly whenever the virtual cpu =
goes to sleep mode and will not advance if no timer is enabled. This behavi=
or gives deterministic execution times from the guest point of view. The de=
fault if icount is enabled is sleep=3Doff. sleep=3Don cannot be used togeth=
er with either shift=3Dauto or align=3Don.

      align=3Don will activate the delay algorithm which will try to synchr=
onise the host clock and the virtual clock. The goal is to have a guest run=
ning at the real frequency imposed by the shift option. Whenever the guest =
clock is behind the host clock and if align=3Don is specified then we print=
 a message to the user to inform about the delay. Currently this option doe=
s not work when shift is auto. Note: The sync algorithm will work for those=
 shift values for which the guest clock runs ahead of the host clock. Typic=
ally this happens when the shift value is high (how high depends on the hos=
t machine). The default if icount is enabled is align=3Doff.

      When the rr option is specified deterministic record/replay is enable=
d. The rrfile=3D option must also be provided to specify the path to the re=
play log. In record mode data is written to this file, and in replay mode i=
t is read back. If the rrsnapshot option is given then it specifies a VM sn=
apshot name. In record mode, a new VM snapshot with the given name is creat=
ed at the start of execution recording. In replay mode this option specifie=
s the snapshot name used to load the initial VM state.


You can read more about how it works at: https://qemu.readthedocs.io/en/lat=
est/devel/tcg-icount.html

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

