Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D9745DE8
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJzz-0000jI-TM; Mon, 03 Jul 2023 09:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzi-0000Wm-GX
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzg-00082V-FW
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so31245225e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392411; x=1690984411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpruFFgP8xcMdCiQPGu5amTD00E3kD8SzCu5zRJBIyU=;
 b=jY20W9h4He/DZmm1RoxtgLDuURKBc6eTUts6ucQxCXljIDzhzJCbKKO/bshdDrXeft
 7JDnbnXiP4CB8JP3Z/1lmuv4Mag+fjR98JFcvbLUT+HGNVdaYktBozt50VbkdKVyTKXd
 h8umoe0Mcis0tpBIY8BIGC7jDIbaPkLebBquLjBTbmjD9f60s6VfJTtc3GLrlFj6unsk
 h8QpH61qN2zYHrRXuXNfsydpsAQPi6ae2CvpPpT1JJReQI2i1JQreZXhUcw9kQkUtPbx
 qjO81ZW3B4roNHgiun60keWja0nYILRa9R2sL9/xibaXRwliu1DxwbyyB989+XX/9XYN
 YpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392411; x=1690984411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpruFFgP8xcMdCiQPGu5amTD00E3kD8SzCu5zRJBIyU=;
 b=Bum75Td3TUAjktPMy0czv7Ir7MJkfJCBjNnYP0DQ/D/0fPMQrCYgTyZjvPI35yMqtp
 bqUZ9+NX+3fxoSOM2YcpoAAlCeOrHC7Bm4I97Lb0+AlCcif+MAViJmWIlbovBUZnqcXc
 zuoBfYkHk1tbfvL72gOiQVl0f1LFi/wmJVUrkrZ/hHGcpGzbpW0G7Gs3mI2QVbyjiMD+
 2/dGHHX5g26uSCPfI5jsH59qQuM0+q6/yEpSz6WU1EYC9FQl6Te/K77egZiuyZwaLl04
 o+HXGTJd89b0JxWKNydhdpzxOwnNddhAgzCgGGtmvr9Q9i6woaxoScoDQqWpX032tO+L
 /rzA==
X-Gm-Message-State: AC+VfDyu4HaxxeQOkktC6lXVEBl8/XUvvheatiuBllccrpp8PKeuPAUN
 nzUyC8/w9if5rvKp4XXiAKpzrQ==
X-Google-Smtp-Source: ACHHUZ778XVMueB7vhDy51j6b5CAR3ADYSwRVtAgkNww34d3vA6XyNz8YXKBEio8+jZGpZr2MNIBcw==
X-Received: by 2002:a1c:4b17:0:b0:3f9:255e:ee3b with SMTP id
 y23-20020a1c4b17000000b003f9255eee3bmr13612988wma.30.1688392410893; 
 Mon, 03 Jul 2023 06:53:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f9b24cf881sm29873522wma.16.2023.07.03.06.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF8E01FFCE;
 Mon,  3 Jul 2023 14:44:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 25/38] docs/devel/qom.rst: Correct code style
Date: Mon,  3 Jul 2023 14:44:14 +0100
Message-Id: <20230703134427.1389440-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Per commit 067109a11c ("docs/devel: mention the spacing requirement
for QOM"):

  For a storage structure the first declaration should always be
  called “parent_obj” and for a class structure the first member
  should always be called “parent_class”

Adapt the QOM rST document accordingly.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230622101717.70468-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-26-alex.bennee@linaro.org>

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index c9237950d0..2828843058 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -26,7 +26,7 @@ features:
    typedef DeviceClass MyDeviceClass;
    typedef struct MyDevice
    {
-       DeviceState parent;
+       DeviceState parent_obj;
 
        int reg0, reg1, reg2;
    } MyDevice;
@@ -147,7 +147,7 @@ will also have a wrapper function to call it easily:
 
    typedef struct MyDeviceClass
    {
-       DeviceClass parent;
+       DeviceClass parent_class;
 
        void (*frobnicate) (MyDevice *obj);
    } MyDeviceClass;
-- 
2.39.2


