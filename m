Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6A1725AEE
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:44:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6pgn-0008Dp-TI; Wed, 07 Jun 2023 05:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6pgi-0008DK-7T
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6pgg-0006MM-1P
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686130961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zyPmjRLLobgmLblEtMkWpUYqbnuIIhNTzrkgEJAkfOw=;
 b=CToNJmUpk0MK82PWgky+DcbD9UtdfqJXUratIik3nNW3Ps74vaOl6uStL7I5KONbxuK9+4
 0P0PDXx2Jl89EUGTtdC/83C0AwOCqn0xFdZVEe3U3HniLFl8tdiWzowF474J1SRXhV8U1y
 rGmQrP0C1Tu0pBL7nMDOl5D6ahXVyH4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Dt42aAgUOMGvUKD5LS3U8A-1; Wed, 07 Jun 2023 05:42:39 -0400
X-MC-Unique: Dt42aAgUOMGvUKD5LS3U8A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f72720c592so34249965e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 02:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686130958; x=1688722958;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zyPmjRLLobgmLblEtMkWpUYqbnuIIhNTzrkgEJAkfOw=;
 b=V1qtDTrZGYmdI7EOSKu1LWqLYxpr5mZBwMY3p0qaWLISAZOTP/m1aIO5Jw3B6uxBKb
 VXYbqvP63hfoOPQTvoIYHsth1YNvcNfSREKj2KfnojimvH2WAZl1UP0Ff+qdbIZPGz+K
 cC9gk0J4tDlY5+96jEfWPQnl0W3WzaRGRHWBDj1Tb1ro4JdzFX7w/x37j0rzcrGGfhfu
 5R+WXV40mdVMCVnvkgY5TxFVqI0390CFQBTsZlTlHx89Uqsekzu7iE81KRJX+7/hgnCt
 YECyiycYFt0YZOA9//yBQ0FoW6y/O9ERhKwXDLCJnkXVaYWWKgFkAo7QbxmClPFVZT/o
 0cuA==
X-Gm-Message-State: AC+VfDwRjSX59fT/4Ev7hc/o6HOWauVvYB1YwT+0kmHqQsuNGsWqvJ1G
 IknGu0/7YXBkE+qSJoChC9hxs+X6/puN0Q/96J0sdaSMl5IrD4MOXlK0B2r2GAV6ioKtLcJ9JLj
 qLuUzzfaFOko1E7NQw92hsuc=
X-Received: by 2002:a7b:cbd1:0:b0:3f6:3d8:aabb with SMTP id
 n17-20020a7bcbd1000000b003f603d8aabbmr4124972wmi.38.1686130958716; 
 Wed, 07 Jun 2023 02:42:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QhqrduHh0qLA1xW5W2StKBH/AFPIpy5o4+zuE8As7Eks9I2SQAxA8WLTnkZW+ncNCufky4w==
X-Received: by 2002:a7b:cbd1:0:b0:3f6:3d8:aabb with SMTP id
 n17-20020a7bcbd1000000b003f603d8aabbmr4124959wmi.38.1686130958423; 
 Wed, 07 Jun 2023 02:42:38 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-92.web.vodafone.de.
 [109.42.114.92]) by smtp.gmail.com with ESMTPSA id
 d8-20020adff848000000b0030ae849c70csm15035394wrq.37.2023.06.07.02.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 02:42:37 -0700 (PDT)
Message-ID: <b869ab5c-7b2f-93fc-678f-53ee39118f97@redhat.com>
Date: Wed, 7 Jun 2023 11:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Building of docs does not work anymore
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


  Hi Paolo, hi John,

since the recent reworks with the Python venv, building of the docs does not 
work for me on my RHEL 8 installation anymore.

If I just run "configure" without any additional arguments, I get:

------------------------- 8< -----------------------------
$ ./configure
Using './build' as the directory for build output
python determined to be '/usr/bin/python3.8'
python version: Python 3.8.13
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=0.63.0
mkvenv: installing meson>=0.63.0
mkvenv: checking for sphinx>=1.6.0, sphinx-rtd-theme>=0.5.0

*** Ouch! ***

Could not provide build dependency 'sphinx>=1.6.0':
  • Python package 'sphinx' was not found nor installed.
  • mkvenv was configured to operate offline and did not check PyPI.
  • 'sphinx-build' was detected on your system at '/usr/bin/sphinx-build', 
but the Python package 'sphinx' was not found by this Python interpreter 
('/usr/bin/python3.8'). Typically this means that 'sphinx-build' has been 
installed against a different Python interpreter on your system.

Sphinx not found/usable, disabling docs.
------------------------- 8< -----------------------------

If I enable downloads and enforce --enable-docs , I get:

------------------------- 8< -----------------------------
./configure --enable-docs --enable-download
Using './build' as the directory for build output
python determined to be '/usr/bin/python3.8'
python version: Python 3.8.13
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=0.63.0
mkvenv: installing meson>=0.63.0
mkvenv: checking for sphinx>=1.6.0, sphinx-rtd-theme>=0.5.0
mkvenv: installing sphinx>=1.6.0, sphinx-rtd-theme>=0.5.0
ERROR: sphinx-rtd-theme 1.2.1 has requirement docutils<0.19, but you'll have 
docutils 0.20.1 which is incompatible.
ERROR: sphinx-rtd-theme 1.2.1 has requirement sphinx<7,>=1.6, but you'll 
have sphinx 7.0.1 which is incompatible.
------------------------- 8< -----------------------------

Any idea how to fix that?

  Thomas


