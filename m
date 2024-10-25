Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0664B9B062D
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 16:51:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4LdZ-0001Mf-Tw; Fri, 25 Oct 2024 10:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1t4LdS-0001MC-PL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:49:55 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1t4LdP-0004OO-Dt
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1729867787; x=1730472587; i=deller@gmx.de;
 bh=GJmlleinGW5xwqhU3Qg2VPQTDv7eVnqrkdtNjpUJrjg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Q2vx4t/8rx7McrX8djP/jiDZZXm5p7O5RQxE0VhnuDymAvuuuXmRmM07DTLCFoT8
 B6f+t/GUYc8xiZd4VigTJnJ6cx1vtwyq9Pm8eJPVKx0o9othQBPHyZowDlogLXOCG
 jkExg1tF5w7ABZc2AcJZx/CIB44olp5Mw6P7zOhpna4nX5X3++vwyvsc6vbbwCE4w
 hgKfaHYKaN4lU3yTnCr2Zy49S29ikmDR7vh0Wuvff/tmKEIjohf1W5JkbEX5BE3aQ
 6RXyQ8Ub5n7VWuPYx4eJCjn4bn1jdXiJxbTcz7jXvzYuwd0I35CyQ0BCpeZvFNXh0
 cINt2JtXvRoCL4VIbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1tJYCQ1z1V-00Wzzw; Fri, 25
 Oct 2024 16:49:47 +0200
Message-ID: <e5e9e5e8-febd-43bf-bfad-8932b29fdd0b@gmx.de>
Date: Fri, 25 Oct 2024 16:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] softfloat: Set 2-NaN propagation rule in
 float_status, not at compile time
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wBOhDvFp00ZWHo1+AErhA0D+gfWPSKjiJXvk0mjgFY/tJyCo2Oe
 FeOps+E2Ru++nzswtnm8SyIUkp1f3O5SNtrGfUInp+5PEF5DLibGI5ANDRjr82ChcGNTA6B
 S1946cAz0qATB86wtm6gc296Cujz13yPuNHAuhlzztnTO6bJ1yz+SfQ7t8pH5IUK0h0wr+C
 f54iu/ssTMgPkjclWUm3w==
UI-OutboundReport: notjunk:1;M01:P0:W5Bc0iNnpfw=;oeo8SW6d+Y/3E4PunjGRjEbBOe2
 kF9VpERf8A7qPCBC0W/uA55tIFM1B6n7bMoU1LEWlhfgK2lvdakCpbo3bqKJMtpFdf93IYPGx
 +E3oHC8Enb4EvMVHpby+2dR33uDT8zSHhSSbm8i3UPGNqUvG84sG5yC2MRKFcbJjE4CZTt41B
 fnN5jBrUKc6QZjYDbgyWJDYS6XOznYYXx/N2lDw05bVycT7nclRcrHL11vvmoNCc2tzOBWua7
 ygJ2hFGgrQoVQ1w3iXamvTjeYLrtY5DAiGpBaq0O/E6ckrBMwB67Q3QXE1W1FzK/xMcHGP/0h
 sTllhQLTy3zAS9c6l1BeeK5A1Z9b8+LbS0S6196m/mf326BkG+zTsgnX/iMtZmtv/KJhYhpdh
 bZE0BLsHbVSWCI1Y4DVDh5cLq96y99/xQM0rg2HpNrijHEaV8SgXu6iAPRMzWR9bZwrLJgzaS
 kCCIo8sGKQ5Kg/fT+wqE2JvT7F3f3OTKTye7A+IVq4YLdquNVrlwSt+wWSo6c9WCfDLKz8m+0
 VUc9jqCO0FpTTNXpKozIwlgTinSGXu99NPS6LBK0Kq7pFtnyag16z8quUsjFPoN4tztlClEn1
 AOjTWRjlwhvQmeNkKvibNZsjyn2VXcdUmlKXVyT0Gq9aW8Xg04SF0MOVWovNhDINnAEHg4vYM
 3VNTSlV8GxnHuLNR6sjPXr4AyhRDPNSpS6AyoKaJvgxZGTGKVYrv1ADe4Rgfnr0LQnWJODOjF
 yvaIbByQrgDr6HQqLQs+uMuKRUtfAUMnBaX4nChMX0/h5g+xYO1bjnjxDxR2jvQVMs+FhrbSU
 fOEfgTWcN832RTwkpX6J9tdQ==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 10/25/24 16:12, Peter Maydell wrote:
> A summary of those TODOs and other oddities I have noticed but not
> tried to tackle is:>
>   * hppa really ought to implement a CPU reset method
>   * alpha also doesn't implement CPU reset

I used the alpha code as template to implement the hppa machine.
That's probably why the CPU reset method is missing for both :-)

The TODO about implementing: ?
	resettable_class_set_parent_phases(rc, NULL, hppa_cpu_reset_hold, NULL,..=
.)...

Helge

