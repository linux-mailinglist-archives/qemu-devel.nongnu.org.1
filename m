Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E87DF0EE
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:09:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVZH-0004Gb-SA; Thu, 02 Nov 2023 07:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leohou1402@gmail.com>)
 id 1qyVZE-0004GI-6H
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:08:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leohou1402@gmail.com>)
 id 1qyVZ5-0006c3-VR
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:08:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc330e8f58so6226505ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698923322; x=1699528122; darn=nongnu.org;
 h=content-transfer-encoding:from:to:content-language:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ua7/KiWwwQFWyaQmk3Tx3i0Ll78+iD/5tb/8M9SSWCM=;
 b=l6BVsflMpj1b+N3dMBJkgvvK6+GW3P0gOjZpuTWaxVK2tTX8PnekWF7sfMXzRfGZXI
 77jLgPNnTylVpfwGgXCCY4mQtAiIwvLTsMxGj3BZ2HT5iys8uJPmqv8La3hWAhmA0/x+
 CIT1S3nvXNuBa0kvUE/ojyebP19pYaw17HgoyKAgGHqE7nRrLntzVb7DyEA600A/lQ0/
 RYROVd/jL9ufk7Eo0QhaNT28R0RCEXCH/VvOwTQPZrDqwH25gFl2HUduzgT7qJZKoTRW
 5KXGVfbGjonHrqHKvGS5aHv/uUpDpzh2HvLM5CMxxnkK7lmyj2tLrLn5aZNCo+Ie7a0h
 6X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698923322; x=1699528122;
 h=content-transfer-encoding:from:to:content-language:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ua7/KiWwwQFWyaQmk3Tx3i0Ll78+iD/5tb/8M9SSWCM=;
 b=PqaaI/LMAEASuX2kJ18nobIEIfqEDlpcWOkkt3H6iTwcivHgQWM69tCQFgY4UhRY3J
 FAMZqN5tkl75Z+rqSz9Aqv/MTPtQQPmVNOJVUjJsz737f8FQg2H49wrCa2srxpYY7yFg
 mNGvq9ekswWETyhROLt0m0Wmzrn3aQfF7CPZsITXI+Phhdo6ue+W5iuw7XzPtpmYSJRd
 PlXv8o5b2Q6RbzVd6maJ9JlZheVNaweNukTh01d8u+QPBhz0b+aWTCco/7F6n+yTjpK4
 Lvzb244D/hvpl8W9v6eg566Q5XwH0RkPrhSydTJ8+J27Pqd+yT9P1iGcbKL4nnmswzdO
 lOkQ==
X-Gm-Message-State: AOJu0Yw2txhPq6TdgfEgBzGk/0xQv/Zckt72Ur3Tr14muElBRlsiywSt
 wYSWv1cLjt61jjrH2hwx9OlvANFUktnuhYm+
X-Google-Smtp-Source: AGHT+IHA7ZUc1VfSO1R1mkXQKV88v6uIpLKgFvx7zKOy8n2vfgjd9iJ6RESRl2cS16+aZbvg0v352A==
X-Received: by 2002:a17:902:d04a:b0:1ca:3e40:beae with SMTP id
 l10-20020a170902d04a00b001ca3e40beaemr13504112pll.38.1698923321798; 
 Thu, 02 Nov 2023 04:08:41 -0700 (PDT)
Received: from [10.100.201.23] ([40.83.119.27])
 by smtp.gmail.com with ESMTPSA id
 jg4-20020a17090326c400b001bde65894c8sm2874657plb.268.2023.11.02.04.08.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 04:08:41 -0700 (PDT)
Message-ID: <302515d1-32df-4719-a827-5881f0300eed@gmail.com>
Date: Thu, 2 Nov 2023 19:08:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Leo Hou <leohou1402@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=leohou1402@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, MISSING_SUBJECT=1.799,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Just to test the email address, no reply required.


