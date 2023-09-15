Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D577A1924
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 10:47:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh4Ss-0003EY-5V; Fri, 15 Sep 2023 04:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qh4So-0003De-US
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:46:10 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qh4Se-0005b4-Dx
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:46:10 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5029e4bfa22so3136038e87.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694767557; x=1695372357; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2nVwK/Xj2EPf7VwkebDdUDBWWV1T0uPp8AJM8WHnuS8=;
 b=ex9YJKZnfVHvg+HveJvUPFYRvYaWbcC+mYv+sOg3D59BZFrRQJ/v/Yze5ZJT462Akn
 lxzUxsJV2lflViS6Jn9FmnWJR0Z9RJ2Xgfe+dpV4oKODikp02B8q0KIoXWe+D4r9vc1b
 i7PvlBzBZBk5r8pkO8ftqtW6U26guajZ4Un6XIXJfQadHHmPix6FLdS37meU0bt3uq00
 ZwVtSPw7DjzTIA0ZRnHS+KhONdW3JHAT4BRVuWngymHJgW9Rifdzra9DsFInZtrjz3/B
 6Mzs12z4U0F7KwKVfOAJMNQ8fw2JyJrVozYooTCqJPoibPB6RVKeGUlA6+9jvVP1dcPm
 BIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694767557; x=1695372357;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2nVwK/Xj2EPf7VwkebDdUDBWWV1T0uPp8AJM8WHnuS8=;
 b=C8mN3m063paJ9aq5QlO1nlp4QliwnKf5indNbo7vm9PDM1IPVytwf7YIhe5Z8E8ZxD
 4MaKCDB0s8cQK8454KfHZnfrGzN6vSSOjddS0tbHvlKYJdaE//oYfxeu11+PsoKA6Koh
 hCd/4vyTLGAi9fSKdub62V0pvUVmx61W+6bvB1khGyrsPhW8qZSRD+BYZPWW2I9K5elY
 jDXMfFeehI7LgB2NEbcP/Lrqq8YILx7Imu48Hi5lKtamLnLkDYXBVuwspFnAEw4UFiWq
 yFkvzZIIYnep/wSshTZo8xQMASrPnVx61YZtz8lX5808DtFhB+SsYOwVDvKWfkJ9j8by
 waPA==
X-Gm-Message-State: AOJu0YzRC8lU8ptHdIu/ZWhq7ExRKk7HzKxKuJuX9V1xcBj4pwZPi4bR
 SivUDjQrhgQiOvKVZqppnR/BL8jENeK8pIDC+V4=
X-Google-Smtp-Source: AGHT+IHJlFn6N4Vdtz+gu9MuiXdnhaQzDNgkSXDNf0LEd0migQOkgGTy6HxkSMf8GviRiSVkfjY+gF5a7FrZg7bX/fY=
X-Received: by 2002:a05:6512:3b99:b0:500:bf33:3add with SMTP id
 g25-20020a0565123b9900b00500bf333addmr1135810lfv.47.1694767557122; Fri, 15
 Sep 2023 01:45:57 -0700 (PDT)
MIME-Version: 1.0
From: Juan Quintela <juan.quintela@gmail.com>
Date: Fri, 15 Sep 2023 09:45:46 +0100
Message-ID: <CALUyDQ5Tcby25VQ05REYXsv8v_MO-nVcsHcrQWEAJefPArCoXA@mail.gmail.com>
Subject: Call for agenda for 2023-09-19 QEMU developers call
To: f4bug@amsat.org, Joao Martins <joao.m.martins@oracle.com>, 
 Juan Quintela <quintela@redhat.com>, mdean@redhat.com, felipe@nutanix.com, 
 afaerber@suse.de, bazulay@redhat.com, bbauman@redhat.com, cw@f00f.org, 
 dustin.kirkland@canonical.com, eblake@redhat.com, edgar.iglesias@gmail.com, 
 eric.auger@redhat.com, iggy@theiggy.com, jan.kiszka@web.de, 
 jidong.xiao@gmail.com, jjherne@linux.vnet.ibm.com, mimu@linux.vnet.ibm.com, 
 peter.maydell@linaro.org, richard.henderson@linaro.org, stefanha@gmail.com, 
 imp@bsdimp.com, z.huo@139.com, zwu.kernel@gmail.com, jgg@nvidia.com, 
 cjia@nvidia.com, david.edmondson@oracle.com, elena.ufimtseva@oracle.com, 
 konrad.wilk@oracle.com, Alessandro Di Federico <ale@rev.ng>, anjo@rev.ng, 
 shameerali.kolothum.thodi@huawei.com, wei.w.wang@intel.com, 
 chao.p.peng@linux.intel.com, qemu-devel@nongnu.org, 
 Mark Burton <mburton@qti.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000381e50060561d263"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=juan.quintela@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--000000000000381e50060561d263
Content-Type: text/plain; charset="UTF-8"

Hi

If you have any topics, please add to this email.

Thanks, Juan.

--000000000000381e50060561d263
Content-Type: text/html; charset="UTF-8"

<div dir="auto">Hi<div dir="auto"><br></div><div dir="auto">If you have any topics, please add to this email.</div><div dir="auto"><br></div><div dir="auto">Thanks, Juan.</div></div>

--000000000000381e50060561d263--

