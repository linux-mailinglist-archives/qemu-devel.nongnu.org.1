Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 076237B44A0
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 01:41:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmjYm-0006xz-OQ; Sat, 30 Sep 2023 19:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjYj-0006xD-DR
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:39:42 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjYg-0004oa-KL
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:39:41 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-503056c8195so24573444e87.1
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696117175; x=1696721975;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0vXKRNCHsbu81DpOoqlPQD1/on3heqAOYG9i6urK47o=;
 b=rXAHcFPI9uogO/CNNlWcQh8jWoQJQbzp+PApYkI3JmRCMZrp3czUi1m7pbt6fxEf4C
 ZvBxkbWSPICgACSNLzafNhZ6lUp8YYKHQ9hlgWTpScpwpg7TAIl+HsWYwShyhxDFMybx
 LecAMmXFFGAHo2hSSp97glpvF29YnnMwb+x5qIvH8xVCBlOZxZ8ebqI9pwz01L4L4dnW
 hctqpXzzxbGxZoXQWfRmyGak513qYn84MjDpjgbS4wKkl5bqU62JKyfBN/DGmsID/d/z
 5BSp11gsh5BLqnN1VXq4mukAHhKHQ6VDeiIXK/oolFVyk7LegVd+kXSS+Eebn7TjjKbh
 PTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696117175; x=1696721975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0vXKRNCHsbu81DpOoqlPQD1/on3heqAOYG9i6urK47o=;
 b=T1l50t/79SjF3rlC/g9ekcFs4dnJSjH4hDuwBSsqVMZuQGsO1sK7iiGkzrnVLRj/+i
 vC6TQuJJB7W3MRHzOPrA9kSFvOl1kdixVVhq/fAUoTVeoztWyV8M5D90bPypCB0thQTb
 eqgvJfzg4+mhIMpiequf5GnL4aEBDVZA4QqjUeu6hfc+pQNzb9XMOqJDCjNLfyAl/AYO
 Cz3VH4TlUz61s+Ra9u4oDbgEhSNIMEVkF6Fe1OPPCAV7IIY5eeullgHdyMn2RbfAewQ8
 bQ7QR3O8Xj4Isx5QhFnp/x+yKIdUosXrAKM5URk1IFhQAMKyTVkdk3pyANpPpJlEagX4
 DatQ==
X-Gm-Message-State: AOJu0YwWBDmHuwiOr9SkQ49m/1RRbu1ssUrlN3QI8FqOfjlOJ1kzNIfu
 PGT4H1avHwAfNAluB+sRe6tjdQ==
X-Google-Smtp-Source: AGHT+IFXwrKxIKEdsQ0PiaSDAAhoNDXZnda43PvkctN5Hp9wOIybcFS5Rm6P7gwnSnXlbN63P86xDg==
X-Received: by 2002:a05:6512:3b11:b0:503:1c07:f7f9 with SMTP id
 f17-20020a0565123b1100b005031c07f7f9mr7682002lfv.29.1696117175061; 
 Sat, 30 Sep 2023 16:39:35 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-8.nat.spd-mgts.ru.
 [109.252.90.8]) by smtp.gmail.com with ESMTPSA id
 c19-20020a197613000000b005033948f108sm4013429lff.272.2023.09.30.16.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 16:39:34 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH 0/2] elf2dmp: fixes of code analysis warnings
Date: Sun,  1 Oct 2023 02:39:20 +0300
Message-Id: <20230930233922.9969-1-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::12f;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series is dedicated to fixes of Coverity warnings.

Viktor Prutyanov (2):
  elf2dmp: limit print length for sign_rsds
  elf2dmp: check array bounds in pdb_get_file_size

 contrib/elf2dmp/main.c |  2 +-
 contrib/elf2dmp/pdb.c  | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.21.0


