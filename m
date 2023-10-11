Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE77C4949
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 07:40:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqRwC-0006Ph-SZ; Wed, 11 Oct 2023 01:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqRwA-0006PO-Aa
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 01:39:14 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqRw8-0003DD-7H
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 01:39:13 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b2cee40de8so115967266b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 22:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697002749; x=1697607549; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGNO9vAZ/FcIlaNrxN40TI7A5HUatn2CDM2A70ctlsw=;
 b=z5i6VVe5T7FdlaZO5pGW86smgtWtsEiCHI7VviK4TJ7TKcyEs4umnmljx7WXDNhWGq
 Kn9K/5O5GVH/F2cbDcnUBL7CHbIgBOa83R60gdb3fGQY3uGXxYaylDJ8HCd9CEVmTm7O
 Aok+ApOwblTJbuys1sX7EMtkwJa0B3TRpqgbIlbh9o6vYf9HJb/BQ/Nlw3Vv9KYcg5Fc
 /C8udtwMc8pY9GBzV7uqgk/A/P7aIwudFWX/oyb4SEnZHtr5++nCI3/yD3Kw/+okvvrS
 n9zSz/BsJONn9Pu/0tFSFEG4767rVh/vlElBUHz2Uphs9f9zJ7AE8jn4OEWac0UhCsLo
 1MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697002749; x=1697607549;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uGNO9vAZ/FcIlaNrxN40TI7A5HUatn2CDM2A70ctlsw=;
 b=qmSzCaH5U5FWxyji2O7ccWCpq9J8d0ld0yQq+Zn2oJtv70ilFktwgrJ3vSnTG6Hzfa
 Kjd73DKDnZbobWHe/ph/6B3pybLuHtdQIG+9RLwMEjhoilra7L9b1T6JtMqGj2b0N24E
 +TtUVqGY77kWj9vdpnTSGnlgXaaOzedQ3rXLhObtlcLq3SA+3bXzIDk08jwe61wFYIon
 qVllcqnxYoEtbb2aazzlZHq3AlxJPlgdDUIis5KRv7JSccP+TnS+NGfoADJcoFeGFMYN
 X8VhQBaiawtQU43LE0/eg1Qpa13HTxdYr8kZ+L0d5CGaeGctqxH96cWLUzh7od3Plm02
 mPXw==
X-Gm-Message-State: AOJu0YxCKhv7lKPftNOSdCgnYWDHEOP85QwZIEm7DDxX6cLsCj1WPj7a
 gmTyQvWYmkdEx1uZfuuxQsIz6A==
X-Google-Smtp-Source: AGHT+IEBEJnPV5a71JRwbJIg0wrgyXzvKPJ8X0HKnxWH9j9u3S2oRvui4L+O30+TtF9Ltua9NT10JA==
X-Received: by 2002:a17:907:318d:b0:9a5:c38d:6b75 with SMTP id
 xe13-20020a170907318d00b009a5c38d6b75mr15347257ejb.15.1697002749696; 
 Tue, 10 Oct 2023 22:39:09 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 x6-20020a170906b08600b009a19701e7b5sm9359467ejy.96.2023.10.10.22.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 22:39:09 -0700 (PDT)
Message-ID: <d0e0395a-25a9-18a1-ae97-c77708a94adb@linaro.org>
Date: Wed, 11 Oct 2023 07:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Subject: wiki.qemu.org is experiencing technical difficulties
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Hi,

https://wiki.qemu.org/ displays:

(Cannot access the database)

Backtrace:

#0 /var/www/html/includes/libs/rdbms/loadbalancer/LoadBalancer.php(972): 
Wikimedia\Rdbms\LoadBalancer->reportConnectionError()
#1 /var/www/html/includes/libs/rdbms/loadbalancer/LoadBalancer.php(944): 
Wikimedia\Rdbms\LoadBalancer->getServerConnection(0, 'qemu_mediawiki', 0)
#2 /var/www/html/includes/libs/rdbms/database/DBConnRef.php(95): 
Wikimedia\Rdbms\LoadBalancer->getConnectionInternal(-1, Array, 
'qemu_mediawiki', 0)
#3 /var/www/html/includes/libs/rdbms/database/DBConnRef.php(101): 
Wikimedia\Rdbms\DBConnRef->ensureConnection()
#4 /var/www/html/includes/libs/rdbms/database/DBConnRef.php(706): 
Wikimedia\Rdbms\DBConnRef->__call('getSessionLagSt...', Array)
#5 /var/www/html/includes/libs/rdbms/database/Database.php(3151): 
Wikimedia\Rdbms\DBConnRef->getSessionLagStatus()
#6 /var/www/html/includes/user/User.php(527): 
Wikimedia\Rdbms\Database::getCacheSetOptions(Object(Wikimedia\Rdbms\DBConnRef))
#7 
/var/www/html/includes/libs/objectcache/wancache/WANObjectCache.php(1689): 
User->{closure}(false, 3600, Array, NULL, Array)
#8 
/var/www/html/includes/libs/objectcache/wancache/WANObjectCache.php(1522): 
WANObjectCache->fetchOrRegenerate('global:user:id:...', 3600, 
Object(Closure), Array, Array)
#9 /var/www/html/includes/user/User.php(560): 
WANObjectCache->getWithSetCallback('global:user:id:...', 3600, 
Object(Closure), Array)
#10 /var/www/html/includes/user/User.php(471): User->loadFromCache()
#11 /var/www/html/includes/user/User.php(404): User->loadFromId(0)
#12 /var/www/html/includes/session/UserInfo.php(92): User->load()
#13 /var/www/html/includes/session/CookieSessionProvider.php(131): 
MediaWiki\Session\UserInfo::newFromId('1303')
#14 /var/www/html/includes/session/SessionManager.php(537): 
MediaWiki\Session\CookieSessionProvider->provideSessionInfo(Object(WebRequest))
#15 /var/www/html/includes/session/SessionManager.php(243): 
MediaWiki\Session\SessionManager->getSessionInfoForRequest(Object(WebRequest))
#16 /var/www/html/includes/WebRequest.php(843): 
MediaWiki\Session\SessionManager->getSessionForRequest(Object(WebRequest))
#17 /var/www/html/includes/session/SessionManager.php(164): 
WebRequest->getSession()
#18 /var/www/html/includes/Setup.php(448): 
MediaWiki\Session\SessionManager::getGlobalSession()
#19 /var/www/html/includes/WebStart.php(86): 
require_once('/var/www/html/i...')
#20 /var/www/html/index.php(44): require('/var/www/html/i...')
#21 {main}

