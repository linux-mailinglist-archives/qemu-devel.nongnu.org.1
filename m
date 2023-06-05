Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F47223D7
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67oU-00010R-1d; Mon, 05 Jun 2023 06:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q67oR-00010G-H6
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q67oP-0008TO-QL
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685962304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x3fl9Bs45xDnj45mf6Uj9+uB9PNMRx2xkVHq1z8DA8Y=;
 b=Qau25ces1gJruqe+EGgl3lp8TFkujAYOeQog0SI2KO3zgd3QvYm86qbppbazEywQHwvV6Q
 NjRKtVz8o7dx71ZvH80qkFE2VqP+Sdszdml4SbHVuEoHbVHG2VcTB56twNgfmPssU8tP1f
 N9eiCKG4W6/OdmDFzOahlXlC4wSnYkQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-XM1St-w7P-mOAcq-YxWE5Q-1; Mon, 05 Jun 2023 06:51:43 -0400
X-MC-Unique: XM1St-w7P-mOAcq-YxWE5Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9750bb0695dso281269066b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685962302; x=1688554302;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x3fl9Bs45xDnj45mf6Uj9+uB9PNMRx2xkVHq1z8DA8Y=;
 b=FtnnT5YSjMPhlRgsdohdjbHTLQET1MwbH1T5Wj3DnLriAq3eot3zZYPLW7lnkThFpn
 objiuX9tT3KiFk0YOx5J7/HNbsUzt/btvjV2y+Ps4MDkpLlTXOHnPXSUEeFwKFKcOtl6
 uRAUiD9GyCGBvOrZhPlyFomS7NyVcbJ1sCaBjtZV/SL5CwmOwqWeD8NzmiYU846wIsGW
 t13Lj6Wr49WZ7mCoqjsQvzrwjSi002bG4tFzkoIcQMzkbcUNVxjNYratXSbuYu4Jf0Go
 AeDq75xNHcyN4cuKUUoCu/Kl978zF/21mCGqh5EFEqG77qvXoblHwUw7EppYe1Pm3KCx
 R5dA==
X-Gm-Message-State: AC+VfDx7aOsdY66/QGNc2Rj1n7RToUbitQ+EvmvYjYEj/DTt5IX6Qrze
 /PaX2rPWmqU9gGMk+Bu07QLFEX6KkU6pUBFOJsfcXPDIumpwJ+C5mKvWfXk0J+yc6WdWZSWCWLH
 m6EZnIT8yRxR9bYw=
X-Received: by 2002:a17:907:da1:b0:969:c354:7d9a with SMTP id
 go33-20020a1709070da100b00969c3547d9amr5017044ejc.12.1685962302281; 
 Mon, 05 Jun 2023 03:51:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EQVvCPp/+2zW47rBJkYXVPZtwShSIe+8zgKew2CuKejNod7w3QwArJl/f8SujPHXUzhT45A==
X-Received: by 2002:a17:907:da1:b0:969:c354:7d9a with SMTP id
 go33-20020a1709070da100b00969c3547d9amr5017025ejc.12.1685962301948; 
 Mon, 05 Jun 2023 03:51:41 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 g16-20020a17090613d000b009663582a90bsm4204629ejc.19.2023.06.05.03.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 03:51:41 -0700 (PDT)
Message-ID: <814834c9-b257-8cdb-7372-35e689bc37ac@redhat.com>
Date: Mon, 5 Jun 2023 12:51:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Fix venv issues with Avocado by reverting to an older
 version
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, alex.bennee@linaro.org,
 jsnow@redhat.com, kconsul@linux.vnet.ibm.com
References: <20230605075823.48871-1-pbonzini@redhat.com>
 <CAFEAcA8fRWdFMrcy6G6yT-8320UZUf6QA9XO70f7P1ssraedRQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAFEAcA8fRWdFMrcy6G6yT-8320UZUf6QA9XO70f7P1ssraedRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/5/23 11:46, Peter Maydell wrote:
>> To avoid this issue, tests/requirements.txt should use a ">=" constraint
>> and the version of Avocado should be limited to what distros provide
>> in the system packages.  Only Fedora has Avocado, and more specifically
>> version 92.0.  For now, this series reverts to the older requirement
>> (version >=88.1) while leaving further version bumps to future changes.
> If the new Avocado version is broken, don't we also need a < constraint
> so we don't get it by mistake ?

I expected those to be bugs that get fixed in 102 or 101.1, so not a 
reason to impose a strict constraint.  But you're right, the version 
that would be installed from PyPI is the latest; I didn't notice because 
I do have avocado installed outside pyvenv/.

Is the logging issue limited to the one fixed by 
https://www.mail-archive.com/qemu-devel@nongnu.org/msg962758.html?  Or 
is there something more?

> In particular, for a local build tree that currently has 101 installed,
> if the tree is updated to include these two patches together, will that
> correctly downgrade it to 88.1?

No, it won't.  What you can do is "pyvenv/bin/pip uninstall 
avocado-framework".

Paolo


