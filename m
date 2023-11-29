Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA5C7FCDB4
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 05:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Blh-0005yH-WB; Tue, 28 Nov 2023 23:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8Bld-0005xg-2A; Tue, 28 Nov 2023 23:01:41 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8Bla-0003H1-NT; Tue, 28 Nov 2023 23:01:40 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso5483229b3a.3; 
 Tue, 28 Nov 2023 20:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701230497; x=1701835297; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSYd/WLHvOZ6KlygnEHMfjwMAYIoOP8ch3+oFfJt2Yg=;
 b=ECm+BF1SJgGvE0G4J+7osTLDJqdLRAVshpE5AzZfJbcioZ+5WPsQtc84BwBm9C5rNp
 U0HrKDhyDqeuLPjnZy5EnMb+TycA9LeCLfFYnVAjUCMHJ2Nv8lxv7usUAgSJQ7IGxGxu
 LTA4OcXK4XY3r6nkqxxyDzxJbnrt7/l+imioqh6UXGV6AM5fvZlSyAfnffqZZJzf+Q18
 troEc2BWiEg1PrmIbE1KuoiPDLaGwccghsZy5Qc2Mgg5wECVeHHotlnAUMfgmnOvFtYt
 l1MiEhw0i5e2ljEs9mVv1G8eGOKp/jDe9tDPi3gjMEPg4+nxbSz/9HBiz8PpaIFBMHE6
 fvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701230497; x=1701835297;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tSYd/WLHvOZ6KlygnEHMfjwMAYIoOP8ch3+oFfJt2Yg=;
 b=lOGfHCqJpUmrEwf3VbOHU3ddjoWoCBmY7xPIsuq8o/I2/Oz8znCK1dfUyoYMWmfxYw
 v60BEokzfyIM2MdP0ZfRZFSgKjBfUUVUCpEnVDJhz5H45himkS8P5CVwVg1J+hG9h5Kw
 xirYW2Su690mqzASP5uytsh8/OiA7ISOS1R4Z4Ttz2n1qpDQr8D0jSA1mv4q0gAWtpPf
 ito8VF3H54kVHgVlA4vLqD/8Yg9Z3XsaTZ99giPX/30RcRW8JOKJMrN26sxsr1zx+4PS
 NnYroVE0GdcLgGDcJy0xXSYXscSownYw0CX+OdsaCAZBqvkuAQOjT+Em4cXt6cPQr07J
 SZRQ==
X-Gm-Message-State: AOJu0YzOV20tuelF7GNUBXE2lS75gGB8KVoWO04oAKR+xc1rNRoFyV6L
 S0ynALwTrJvqaI7AD1HufVs=
X-Google-Smtp-Source: AGHT+IHqTgRVW1PYD+1MXPjBHnXTNNaCZ25/R6D5OH0ObvGQ5tgoVQei01R/Gky7kyayoL/t85VM0g==
X-Received: by 2002:a05:6a00:391f:b0:6c3:3213:2d17 with SMTP id
 fh31-20020a056a00391f00b006c332132d17mr19156167pfb.29.1701230496779; 
 Tue, 28 Nov 2023 20:01:36 -0800 (PST)
Received: from localhost ([124.170.16.164]) by smtp.gmail.com with ESMTPSA id
 it18-20020a056a00459200b0068fe9c7b199sm9677751pfb.105.2023.11.28.20.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 20:01:36 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Nov 2023 14:01:31 +1000
Message-Id: <CXAZVME5KCFG.32WTQX49G8W7B@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <clegoate@redhat.com>, <qemu-devel@nongnu.org>, <mikey@neuling.org>,
 <vaibhav@linux.ibm.com>, <jniethe5@gmail.com>, <sbhat@linux.ibm.com>,
 <kconsul@linux.vnet.ibm.com>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 04/14] spapr: nested: Introduce cap-nested-papr for
 Nested PAPR API
X-Mailer: aerc 0.15.2
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
 <20231012104951.194876-5-harshpb@linux.ibm.com>
In-Reply-To: <20231012104951.194876-5-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Oct 12, 2023 at 8:49 PM AEST, Harsh Prateek Bora wrote:
> Introduce a SPAPR capability cap-nested-papr which provides a nested
> HV facility to the guest. This is similar to cap-nested-hv, but uses
> a different (incompatible) API and so they are mutually exclusive.
> This new API is to enable support for KVM on PowerVM and recently the
> Linux kernel side patches have been accepted upstream as well [1].
> Support for related hcalls is being added in next set of patches.

We do want to be able to support both APIs on a per-guest basis. It
doesn't look like the vmstate bits will be a problem, both could be
enabled if the logic permitted it and that wouldn't cause a
compatibility problem I think?

And it's a bit of a nitpick, but the capability should not be permitted
before the actual APIs are supported IMO. You could split this into
adding .api first, so the implementation can test it, and add the spapr
caps at the end.

Thanks,
Nick

