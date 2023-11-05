Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A063C7E1413
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 16:23:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzewa-00023Q-C0; Sun, 05 Nov 2023 10:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qzewY-00022v-AQ
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 10:21:42 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qzewW-0002Om-Gt
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 10:21:42 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc316ccc38so30019105ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 07:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1699197698; x=1699802498; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MN8rDsDSy/qp4b5uLx80qlm3rDpHoiPOiy4Aszo7r/8=;
 b=D9GGkzbQ+380m4ctMl6zURu0kJB3q8I5pEnXO0g93qIcRdpaC+xD8tOhElGPFiMR9F
 35p0iioD97C47vCapnyrvnOHonyigwtpJKISJBspaD3s3fWeEH+yjrsBpMTVgYkJMztS
 eiPxviCH07z2MYZs2fdgs6XGxnP4dssDv1DpwzlIIw3c9FwVLoKBTiIcVADg6YYKQ5uY
 XXsyhnFlhZeSO5TjwmKn0KOT+uiaKTPoNGwIU7SI+WJ1OsGQIeA0MG5VL7FOvPPHRouv
 z91HJeQ3AAURKjr6YeBoX5K2Bn6loqoINYJ4h2PnHKzPOG1+nqbviOWRaHkypVhkTA90
 Dg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699197698; x=1699802498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MN8rDsDSy/qp4b5uLx80qlm3rDpHoiPOiy4Aszo7r/8=;
 b=FXOyg/kFCOPqlFPQhCrsObIbIc5M6cOO0+r01pakbIkg6PaPWm4hEUprGwvUcVrC8W
 WI4JHo3H9jSqXoygdVdf1X++xYRkEoNpdD5z3azNEDlvxOvj+jOouQoOJ7c17tKQwNy3
 kqnE0iBDoU6pOmC+P7nwOzCJ4NRvFaXE77LtOydRtCGBCRk+PrOdlants283GDSdxAo0
 ejCVAjvP5PasgHOwL/NJP2z9nxP7vMI4ekIGo0+6JPxGQN8AlT1LeGNpuXms65boDUN7
 ux8psrtJ+HUV6KplbdCRN1LW9auotKfmVlIvPt9CTnAhIF3bacUhMGFuCP1z42WG77Ph
 CanQ==
X-Gm-Message-State: AOJu0Yyy75D3kDsgTxDzN+stEfP7GLf1MBKGw0qRQP91JpRaSyMk30kR
 POHTudu3hlsmkd+whU0nZiZovA==
X-Google-Smtp-Source: AGHT+IEtr3GNLDN5mKzMgNMRdSBx685Rz8PDtJe2oAw4aXuPugQWKBIhSr4OVrGD7GaEtuorF4ziwA==
X-Received: by 2002:a17:902:cec3:b0:1cc:5f51:b1ed with SMTP id
 d3-20020a170902cec300b001cc5f51b1edmr16533337plg.47.1699197698138; 
 Sun, 05 Nov 2023 07:21:38 -0800 (PST)
Received: from localhost ([123.231.99.131]) by smtp.gmail.com with ESMTPSA id
 i2-20020a170902eb4200b001cc79f3c60csm4318890pli.31.2023.11.05.07.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 07:21:37 -0800 (PST)
Date: Sun, 5 Nov 2023 20:51:33 +0530
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 dirty@apple.com, rbolshakov@ddn.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] i386: hvf: In kick_vcpu use hv_vcpu_interrupt to
 force exit
Message-ID: <ZUey_ZynRm9XwQLD@roolebo.dev>
References: <20230922140914.13906-1-phil@philjordan.eu>
 <20230922140914.13906-3-phil@philjordan.eu>
 <ZSLzq33DgMNYBsQT@roolebo.dev>
 <CAAibmn35JypPWfUophMgONTkgbYFvaaRhuD9+1kif9EOFx9HxQ@mail.gmail.com>
 <ZSMAr3hhxJryGpya@roolebo.dev>
 <CAAibmn3cMjnNWsQs8yCetc__Kr+ujn6Gn_ohGubVA3hCQbBy1w@mail.gmail.com>
 <CAGCz3vu=sX1m4PJiOvtTBza4iNUy6Hj+AtSAFi33zJ=dz_r7UA@mail.gmail.com>
 <CAGCz3vt2VB9i8+o-qFPpDptu81p3r00-TKfCV3O+=dQ0r3d88w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGCz3vt2VB9i8+o-qFPpDptu81p3r00-TKfCV3O+=dQ0r3d88w@mail.gmail.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=roman@roolebo.dev; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Fri, Oct 20, 2023 at 05:12:13PM +0200, Phil Dennis-Jordan wrote:
> Hi Roman, hi Paolo,
> 

Hi Phil,

Pardon for not responding earlier. I was travelling the last three weeks.

I appreciate the time you spent on the rebase. I have compiled it and
observed the same issue with SVGA like with your third patch.

> Just an update on my investigation of the hv_vcpu_run ->
> hv_vcpu_run_until issue. The graphical issues with the Windows XP VM
> appear to be caused by the dirty memory page system not working as
> expected. The emulated (Cirrus) VGA adapter uses dirty page tracking
> to perform partial screen updates, so when pages aren't marked as
> dirty, they don't get updated on the host console.
> 

That sounds awesome, I think you have tracked it down correctly. I have
also looked at SVGA code and the only idea I had is dirty tracking is
somehow not working properly.

I observed similar issue when tried to add GDB stub for x86 hvf. The
changes from GDB stub produced no apparent effect on the guest -
breakpoints were there, in the memory but did not stop the guest and so
on. I got lost why it didn't work back then.

> This got me digging into how dirty memory tracking is actually
> implemented in the Qemu hvf backend, and basically, it should never
> have worked in the first place. When we get a write fault, the code
> marks the *whole* 'logged' memory range as writable rather than just
> the page that's just been dirtied. It just so happens that hv_vcpu_run
> was causing EPT fault exits on those pages even after marking them
> writable (?), and hv_vcpu_run_until() no longer does that. So
> basically, this has been a Qemu bug masked by undesirable
> hv_vcpu_run() behaviour. I'll start putting together a fix for this.
> 

Sounds good, have you got anything to test or review? Meanwhile, I'll
review the pending patches you sent.

Best regards,
Roman

