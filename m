Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D9D825887
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 17:44:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLnIF-0001JD-0B; Fri, 05 Jan 2024 11:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLnID-0001J5-KO
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:43:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLnIC-0006Bk-1H
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:43:33 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e37524fafso9508145e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 08:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704473009; x=1705077809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BgcfFribFghRQXHP9MDmW6sivQs+B9t4EwDp8f5u3c=;
 b=L/pBrpyC5ZQ0kg306w6YZBOsOZdAQzWUyuGNW0oMdcNf9mUZ6o/N6jSDTnYl+nEckH
 3V8rn3mldbM/pBuntAMIsB1UZ0Nb7qfyveXWNLaQK9TU8nyzJrqmqutWwV1tW+yr9VLQ
 6vAzcjt+ttzocFlR5rC05fUyC1KIZJT1RxmhN+8+/G1Dn45QBK6o9/DY2P3I0cdpZdZ4
 uUdMkh2TVtvf1CM2LVdgwEJXG34fPioRrF+EfYzTJFMHaG7FwsQAh6Bj8errfs1kMQaq
 N4GbCQZ0AqzV9SlQBj8wzSBthJN/T7p4wf7ijHzIzl0K3vYumW91ft7h5AWTI1mUHYzt
 ywjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704473009; x=1705077809;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2BgcfFribFghRQXHP9MDmW6sivQs+B9t4EwDp8f5u3c=;
 b=hqgadJoB4srvGJ3HDa4wp9kig740mEo2z7G/ikWc1iiJbVPgXI/yvtKEw2vOj3e8Mu
 SivCHpYXo+EbIlUQX9cdtFPRtaWH4itwD1IIkts32RpXzRBM6siWSAMu1FvYe0ivPVSy
 w0YbeX2VWkLQ41fm6evKTVIAkBWd+FHXfdylH7GcbssL03+fiPiQ6fqkt9hgJ7cin/tO
 HYSm+r+8HpTvfwxb1+lItLWQTM0CtdLIZ9WUbWx1yGyLsT2WvuGzwZyyU4HzK8762gSN
 sWPZMAwHvu+/4eFqM+INRnASXjL58rflejr5Z1QbHmV8DFcbz3IlliXpr+eNOsi5txfC
 GyBw==
X-Gm-Message-State: AOJu0Yyu+TUHj2WME/dTsxk9UQ41xx3BIH774YFNBsvdaoXz129WHhY7
 zl4LJUhWa5q55AUm92dAZOkDJdjw0+OteyvGB4YtUF/uAv0=
X-Google-Smtp-Source: AGHT+IGKn+GVwvBldS4zHcCB/wx8KNRoTUCJh7ll18TqeNQOrC8kFOnZAzVu2BwpVFNOf8ss0Gx+fw==
X-Received: by 2002:a05:600c:b5a:b0:40d:89ff:53c7 with SMTP id
 k26-20020a05600c0b5a00b0040d89ff53c7mr1324463wmr.21.1704473008660; 
 Fri, 05 Jan 2024 08:43:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 az29-20020a05600c601d00b0040d87b5a87csm2099792wmb.48.2024.01.05.08.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 08:43:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0714A5F933;
 Fri,  5 Jan 2024 16:43:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] i386/sev: Nitpick at the error message's output
In-Reply-To: <c5033954155dfe256f650fc9ca2084c688356317.1704469721.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Sat, 6 Jan 2024 00:09:55 +0800")
References: <c5033954155dfe256f650fc9ca2084c688356317.1704469721.git.yong.huang@smartx.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 05 Jan 2024 16:43:27 +0000
Message-ID: <87wmsneno0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Hyman Huang <yong.huang@smartx.com> writes:

> The incorrect error message was produced as a result of
> the return number being disregarded on the sev_kvm_init
> failure path.
>
> For instance, when a user's failure to launch a SEV guest
> is caused by an incorrect IOCTL, the following message is
> reported:
>
> kvm: sev_kvm_init: failed to initialize ret=3D-25 fw_error=3D0
> kvm: failed to initialize kvm: Operation not permitted
>
> While the error message's accurate output should be:
>
> kvm: sev_kvm_init: failed to initialize ret=3D-25 fw_error=3D0
> kvm: failed to initialize kvm: Inappropriate ioctl for device
>
> Fix this by returning the return number directly on the
> failure path.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  target/i386/sev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 9a71246682..4a69ca457c 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -1019,7 +1019,7 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Err=
or **errp)
>  err:
>      sev_guest =3D NULL;
>      ram_block_discard_disable(false);
> -    return -1;
> +    return ret;

I don't think this will be correct in all cases because there are other
legs (e.g. if (host_cbitpos !=3D sev->cbitpos)) where ret may be the
successful setting of ram_block_discard_disable(true).

You might want to explore if the function can be re-written with
explicit return's and utilise autofree to do the clean-up of dynamic
objects.

I think this entails setting sev_guest at the end of the function just
before the return 0.

I'm not sure if there is a clean way to handle
ram_block_discard_disable(false); cleanly for all the failure legs
though. Maybe someone with more familiarity with the code has some ideas?


>  }
>=20=20
>  int

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

