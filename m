Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AEE7E54B3
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 12:06:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0gMd-0004Gp-OI; Wed, 08 Nov 2023 06:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0gMc-0004Gd-3X
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:04:50 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0gMZ-00067f-4K
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:04:49 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9be02fcf268so1006598366b.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 03:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699441485; x=1700046285; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmE14V+x/6ODwbZ+6rHSJK5bv+kwYgsIH6GVzelb2Fk=;
 b=se8KmTR8DqYkzp8YjtpOnUBmE1ARGMPXs0/TKfz8GLQ1wJuVtg0X3O7evgo/4dUHwZ
 cscI7PBaFpvp4s6zyvwd+GdSwWrcAZh/5m1AnhcLuzNkK5STBEIAIcDjafbi/xupCKr9
 1drHwG+eqyQ9TH8KGSPGYmnUQ0wZBuXTJSznMqmd3HpZLxb1NMRXd+p8XvMtrmLx+tVr
 0ixQZl2cQn0FNCKVfB8a6IPvosuGKD/UN/1zN7iH8JLcdPgPryd6YWUoUzgNELkMIydQ
 mm0Pkici2Xjz6kUZIOfjtmxuY/trZSPH1LLo/8BotIWmwVOVqG3i08uCpuEZ4s64WgnL
 6J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699441485; x=1700046285;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kmE14V+x/6ODwbZ+6rHSJK5bv+kwYgsIH6GVzelb2Fk=;
 b=G6Yq25vcHrr8tsvty0yLqB14k/2weTUmnj9uQ/18crHvzwoVUE1w99Ji3DONAjA5Ck
 Fu1Z6CzfVUPQqQzVSVCcUBqoSomOtgeS3tCQxbyeYuOeLc/9p+oSUVQ/SyFjdcABx2kS
 Xjgu0pa1TGzLBiuZ1ShtQurqq0KMIg/5gWibIeeFF+AzGSzu/RQaW9wGUpbgsBVDI9i6
 0JofWpgpuVuPLH/UNsYNnoQpeu7UmzksR/TSRn7X/nCxY+diinegOj7S6W+315ZrXmYg
 swoYlozQOvbF9ec6uG15FpPKORh58DoVYmv9Fzzxms8EXK4Iz8p4cA8vQt+Hl1893rR9
 EL7A==
X-Gm-Message-State: AOJu0YwtAsml9rU2hYHWgZ43Qhv+n2L3w0Sac6YDpqphO+nx+IUopxIy
 w2DJ7e8Njy0FATZ5zsd4oImtYag30ZnHEYf1c7M=
X-Google-Smtp-Source: AGHT+IFbjekQN362s9h6X+UHL0MVNR3cbi48VkhPye6nIdow8TrZixN7Lug2uFJBm7sdSmQHbFF3hQ==
X-Received: by 2002:a17:907:7243:b0:9be:ab38:a362 with SMTP id
 ds3-20020a170907724300b009beab38a362mr1043768ejc.46.1699441485079; 
 Wed, 08 Nov 2023 03:04:45 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 q24-20020a1709066b1800b009b2ca104988sm869896ejr.98.2023.11.08.03.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 03:04:44 -0800 (PST)
Message-ID: <7dfb93bd-314d-4d62-8bac-64f5fdf93c22@linaro.org>
Date: Wed, 8 Nov 2023 12:04:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: virtio-fs@redhat.com bouncing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Hi Stefan,

You are listed as virtiofs maintainer, see MAINTAINERS:

   virtiofs
   M: Stefan Hajnoczi <stefanha@redhat.com>
   S: Supported
   F: hw/virtio/vhost-user-fs*
   F: include/hw/virtio/vhost-user-fs.h
   L: virtio-fs@redhat.com

Mails sent to this list address are bouncing:

<virtio-fs@redhat.com>: host int-mx-rdu2.corp.redhat.com[10.11.203.6] 
said: 550
     5.1.1 <virtio-fs@redhat.com>: Recipient address rejected: User 
unknown in
     local recipient table (in reply to RCPT TO command)

Maybe the list need to be updated, like Daniel did with libvir-list@?
https://lore.kernel.org/qemu-devel/20231027095643.2842382-1-berrange@redhat.com/

Looking at other lists, I also see secalert@:

   $ git grep L:.*redhat MAINTAINERS
   MAINTAINERS:86:L: secalert@redhat.com
   MAINTAINERS:2231:L: virtio-fs@redhat.com

So Cc'ing Michael / Mauro.

Regards,

Phil.

