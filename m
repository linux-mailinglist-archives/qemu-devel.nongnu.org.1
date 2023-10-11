Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EEF7C56B2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:22:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa6E-0005Lm-A4; Wed, 11 Oct 2023 10:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa6B-0005IS-KA
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa6A-00023M-7B
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034125;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lUNVVQoAFlpVPIW7ATGIzVMW9g1UNsbeC9n8oiJzXsU=;
 b=FxUhH7AN3UDgxtsva/mbdXPE41fFfW8Lg5SaDwuNcXEQItowXooIk1DQj6dod2LswUbw5d
 4QwSqRPvWpIWzsW/1obJ3Vlnj0Ns5BGF1vxFssfeES8/jxGLnOnQ3mDKUOXEl3s3e8Wpqs
 og2p0hmI9zzpptiGHR6Ihcsgc+quYDY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-Ssgx8abyNxe_hOcIp3DkwQ-1; Wed, 11 Oct 2023 10:22:03 -0400
X-MC-Unique: Ssgx8abyNxe_hOcIp3DkwQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4054743df06so49359835e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034122; x=1697638922;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lUNVVQoAFlpVPIW7ATGIzVMW9g1UNsbeC9n8oiJzXsU=;
 b=K6V9tQKe1M9q3+Qu0RWSh1LwFYEx3I9DOrUgE9M+Nad5YkfVWFyzfiKKkxgFdOYz1o
 1+pbVQP0X2B08sJipH5l0OMgl8J5S/IdCKm8v5HVLvIksp7XxFsasbi051wZqZq7mP5t
 yYolUtZ5g36jfAEMp99ACFTMBjEvFsHjAPjuG1sbYLzO3UozuFH2UBxfe9BViqDSmIZS
 fBfqENNIO7ueiP2xsZACK8vmSBvyrFm/yhcbVdo906ePJZCBNXeRanch+z8si3VxKC7R
 ZYUuaxx05sfUxk6RFPP2vXf1H/YjMLOcPCl/imHMKRkDgyo8/GuqczTT+NlBHCF/3OGv
 m56g==
X-Gm-Message-State: AOJu0YyYJpVxTqXdd+PFFn3T6DNDR58VJGakXdu2/qe013TyvWyCUSBp
 SwUJsZskoa8JZIGkrhdqTkHhaLACAMuZLgsl1XKobs6I04AFnRPZHvGK3nN7Ynj2Cnf574+cgvO
 5Me6OdcMHkqNTtdw=
X-Received: by 2002:a05:600c:b59:b0:3ff:233f:2cfb with SMTP id
 k25-20020a05600c0b5900b003ff233f2cfbmr18869037wmr.23.1697034122020; 
 Wed, 11 Oct 2023 07:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy+Ci4yJlYq0R/hoKcTGoouwJLpsQVcmoWADTkesaRJw9xqpllZoNJJepqldlRJwRVPogdnw==
X-Received: by 2002:a05:600c:b59:b0:3ff:233f:2cfb with SMTP id
 k25-20020a05600c0b5900b003ff233f2cfbmr18869017wmr.23.1697034121726; 
 Wed, 11 Oct 2023 07:22:01 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s11-20020a7bc38b000000b003fbe4cecc3bsm19223779wmj.16.2023.10.11.07.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:22:01 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/9] tests/qtest: Allow qtest_get_machines to use an
 alternate QEMU binary
In-Reply-To: <20231006123910.17759-4-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 6 Oct 2023 09:39:04 -0300")
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-4-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:22:00 +0200
Message-ID: <871qe19r3r.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> We're adding support for using more than one QEMU binary in
> tests. Modify qtest_get_machines() to take an environment variable
> that contains the QEMU binary path.
>
> Since the function keeps a cache of the machines list in the form of a
> static variable, refresh it any time the environment variable changes.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


