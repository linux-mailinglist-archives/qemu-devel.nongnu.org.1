Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF67CDF90
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:25:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7U4-0004jr-D1; Wed, 18 Oct 2023 10:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt7U2-0004ho-8h
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt7U0-000732-Ms
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697639111;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jT4RYAmodD3Z40oT00ZmJ3EMwpg9YVPIx7iCzJYbHtk=;
 b=K9bIESk5t/nKRSToI27O9iYWznqXzcm+/KgDSsB2QOtV5IMsm+Ow/EZ6HPf6QoUw7yNHl3
 b3m1grPrJmO7SM3my9HSipEDYra9Au62IPFOowCLWtB91Lqrh4WoOuvQcABql3Ci3HSP/o
 jf9ncg9ITPCiumV8NavS2oe63Ob61/U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-jVxsvTaqMTm5hRP0zJQ3UA-1; Wed, 18 Oct 2023 10:25:09 -0400
X-MC-Unique: jVxsvTaqMTm5hRP0zJQ3UA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c51d0f97e3so34998971fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697639108; x=1698243908;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jT4RYAmodD3Z40oT00ZmJ3EMwpg9YVPIx7iCzJYbHtk=;
 b=qE/4XUzY5DNg0FC9HMMDCng+KIuJEOnUQ9z7nDufIG34TPz3mD4EWpexII38ssSqgb
 inJp9Un+r/UPODgg/sF488EFdKC5dHXzGPaU1w/k5WwjD6D/RLrMFQiGdsNttitVTslL
 8ltylMPmUiwVnhxGHdw0chz2/MLDBWs2UXP12ISW7+zpqjDNoYTqf5ofh1WQ1pOejaoM
 lR/yXZ0OTC40HCxf0oz57dCkr7WyHjLrAe9PWOUYaIJeXrN+jQAzz1o2aZ1KtrY0Qde7
 x+zeeg4/VqlfT/no+UWUn4a1mSP38d5rIH66BJSsdfdksbVXJHRZ7j+cAc8GnmSc61/c
 b9hw==
X-Gm-Message-State: AOJu0YywwI7gLxwFLZLMHxEtj3Z8u+MMeFvvL5NyXj4hyaIxWpDFFGe1
 h5kqXxQStlqZTIwxLvyCUER8p5dXuAdCPtUZrI+R+WO28FIy328p/3Us1EqygtBcy92cMqVnSY5
 axwQlsh8cXH8ayLA=
X-Received: by 2002:a05:6512:3da3:b0:507:98d0:bec4 with SMTP id
 k35-20020a0565123da300b0050798d0bec4mr5304633lfv.54.1697639108412; 
 Wed, 18 Oct 2023 07:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLO+CxqVV7USC4G/LNQ4WJPF1HSZ7JclU1hvqtplOG73kD0JnDa9WDjbWwOXJE+pSTn9fChA==
X-Received: by 2002:a05:6512:3da3:b0:507:98d0:bec4 with SMTP id
 k35-20020a0565123da300b0050798d0bec4mr5304608lfv.54.1697639108058; 
 Wed, 18 Oct 2023 07:25:08 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 t17-20020a05600001d100b0032d8034724esm2210719wrx.94.2023.10.18.07.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:25:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 10/11] tests/qtest/migration: Support more than one
 QEMU binary
In-Reply-To: <20231018140736.3618-11-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 18 Oct 2023 11:07:35 -0300")
References: <20231018140736.3618-1-farosas@suse.de>
 <20231018140736.3618-11-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 16:25:06 +0200
Message-ID: <87edhs80u5.fsf@secure.mitica>
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
D> We have strict rules around migration compatibility between different
> QEMU versions but no test to validate the migration state between
> different binaries.
>
> Add infrastructure to allow running the migration tests with two
> different QEMU binaries as migration source and destination.
>
> The code now recognizes two new environment variables
> QTEST_QEMU_BINARY_SRC and QTEST_QEMU_BINARY_DST. In the absence of
> either of them, the test will use the QTEST_QEMU_BINARY variable. If
> both are missing then the tests are run with single binary as
> previously.
>
> The machine type is selected automatically as the latest machine type
> version that works with both binaries.
>
> Usage:
> QTEST_QEMU_BINARY_SRC=../build-8.2.0/qemu-system-x86_64 \
> QTEST_QEMU_BINARY_DST=../build-8.1.0/qemu-system-x86_64 \
> ./tests/qtest/migration-test
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

The test works for me.  But I would really like to be able to specify
the machine type for which I have to test.  I.e. right now, we can test:

qemu-8.2 <-> qemu-8.1

and it is going to use q35-8.1

But in the case that I want to test that two binaries with q35-8.0,
there is no way to setup that.

So basically what I need is

QTEST_QEMU_MACHINE_TYPE var, and if that exist, just use that instead of
the value of "machine"

What do you think?

Later, Juan.


