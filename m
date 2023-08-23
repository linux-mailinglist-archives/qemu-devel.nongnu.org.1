Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F198C78549F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:52:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkVf-0004K6-9f; Wed, 23 Aug 2023 05:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amaury.pouly@lowrisc.org>)
 id 1qYkVd-0004Jn-Gc
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:50:41 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amaury.pouly@lowrisc.org>)
 id 1qYkVb-0002SW-E3
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:50:41 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50078eba7afso5517822e87.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1692784234; x=1693389034;
 h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lulRVUTlqSV0SQyYJRP5xio/XkBz7ubQHTfKiWg0prs=;
 b=WcNbrX8dEg0mQqR3BZ0kAZ/hyHq0DoMsbJc0bQddoFP8nbY4wGmOe65hzpN3/vb17B
 iJIUUqXTepKY4i2rbW7pYl1w0MrA0s39/bfVWFFjaWRGPnuzrQPSlWcdA+d7y7S3lFSH
 0Kbb5t0bEz60e/W/eziBrZTrMXvClfP7wiiNPw+yte+g9lStqi2Rm1ALJfbwi7oLEJZh
 4yVLrBjtfa35FUjwLAd0XHWmyc5hHsm2IxOe6J4Y6pdnuVq+QwxpG5FaliHkeN02sFOf
 hQ/3JQmNG2hu81UTp1SEwu5FK6aQIJ+sZxFdYOnwHK9Mx0eglSKbzOA3ALPybMW2Gq4L
 fvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692784234; x=1693389034;
 h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lulRVUTlqSV0SQyYJRP5xio/XkBz7ubQHTfKiWg0prs=;
 b=CvuCKcaMQDcbz8Nf2jc/lKcubbkMfTh37bhHO6Y9LTnujlhPNYjh+uQ6Fakfk2DhQN
 Rf3xZaJ8Lrmr2e+ik98Dug6gbLIopRsiHp3f2vEfeEkYl8APAQlrOEyKje9/nkHssUov
 P0b298uAYcj9o+MAKNdj194A3iHWyiZ0KTeTlVZPEoIoBk7wocod0jlG6Y1bGMrPTyfk
 rF3621DmDTYeolhUz3NXpCF88Gz5sT2mmGKSBVx93+0J6aS41IMe2S15j7dbiYBNmUqB
 6KWf5HyeI6wihL10j7DyzwDjM8DIv11bu8FfN4jwi/xyyN+PlNzv+8yERSoxyOll70pn
 4fvA==
X-Gm-Message-State: AOJu0Yzj8v6Fu6HtFtDk4jy6VwoVtmhc6wWG/CQZmDlysoDaz7y0ociI
 WQweT0JzKIbr1ED2QJ/huvFejks74kyPVLd5e/6VHw==
X-Google-Smtp-Source: AGHT+IFy0D77tROFiUcLCJgJsLJ8MMJ6f9irnxR7BAYQjvKE6PYqBmsqUdIioGpr8f1HsMgGDQ2UOA==
X-Received: by 2002:a05:6512:3e1a:b0:4fc:3755:37de with SMTP id
 i26-20020a0565123e1a00b004fc375537demr10840242lfv.3.1692784234375; 
 Wed, 23 Aug 2023 02:50:34 -0700 (PDT)
Received: from jamesbond.localnet ([2a02:c7c:a00d:9b00:b971:5693:6b52:53b9])
 by smtp.gmail.com with ESMTPSA id
 r10-20020adfdc8a000000b003197c2316ecsm18303552wrj.112.2023.08.23.02.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 02:50:34 -0700 (PDT)
From: Amaury Pouly <amaury.pouly@lowrisc.org>
To: thuth@redhat.com
Cc: berrange@redhat.com, marcandre.lureau@redhat.com, mhartmay@linux.ibm.com, 
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
Date: Wed, 23 Aug 2023 10:44:54 +0100
Message-ID: <4505709.LvFx2qVVIh@jamesbond>
In-Reply-To: <20230816210743.1319018-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=amaury.pouly@lowrisc.org; helo=mail-lf1-x134.google.com
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

>> When starting a guest via libvirt with "virsh start --console ...",
>> the first second of the console output is missing. This is especially
>> annoying on s390x that only has a text console by default and no graphical
>> output - if the bios fails to boot here, the information about what went
>> wrong is completely lost.

Hi, we recently ran into this problem in a different scenario where we
manually invoke QEMU and connect to the PTY before starting the machine.
With the existing code, we have to add a one second delay before starting just
to make sure that we capture the early boot message. We are now running a 
patched version of QEMU with pretty much the same change as yours and it seems
to work well. We are very interested in seeing this change, or a variant
thereof merged.



