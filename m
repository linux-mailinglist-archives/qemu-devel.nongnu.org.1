Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A71C7C56B0
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:22:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa5D-00029X-Bf; Wed, 11 Oct 2023 10:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa58-00025j-Rw
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa57-0001sL-Df
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034060;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4i01pHgYOKHqWUi6TbE5vaxHGHe5OvZjHuFUyqH/vss=;
 b=H/SzM6TgTmpcmXE+Na3PA+dW/la9Ew70lV5WsmkUzLsGVqhAIcVfXUmgvbv9FyN8SyWEIr
 tr/AZYQ3mEFHMsVnzyUxi4ppYZ7dgns39YXCllmbRYxcEN2HDECYByHV8h0vz3vgz9sqhR
 zstlDxDVwYXjVFLqsHQL6Sm7Q8L4KY8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-uLmDb-DUMtW6g-pSvGiGoA-1; Wed, 11 Oct 2023 10:20:43 -0400
X-MC-Unique: uLmDb-DUMtW6g-pSvGiGoA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4054743df06so49349105e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034041; x=1697638841;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4i01pHgYOKHqWUi6TbE5vaxHGHe5OvZjHuFUyqH/vss=;
 b=dgamS6NGH9Lk1agXxouZ9YuMpqPjkvQW7WKGABCJRED6/p/cB5LjhDlojj+XwWkBHB
 zr/YRGqz/kQEWRSZbMAOiZ4ElXRoqKPJuCKlqQAOJ729rbCyOX1ZCWPCoshYc7OEt92d
 eVON3N6aNtFJGPQI5PoxtOIgtf3ArkFkCzDOot/mlOM6uc+2F955ofuG4xAs8oWMMegw
 8ok4/JHkY83w53dKR273PltkolOMwV8Kmy1p4ZEN84QQjq04hyxiEir5AoajDNnOcHSF
 P64s9zQB1kSl2RrkGOxjBzvqE0SjOvpV8rmuV9o2oIpfdilms02nVZAMUa//uQBQq5pp
 KYww==
X-Gm-Message-State: AOJu0YwJQvgSEG/4JkNuWurIeYyG/LnSwfQh5EUgPyHD4TUlGvJcNQl6
 ZrRVO4YkBPPX7q2JhbZcQT+uM1ptCfPuydEEqp/bx/v9cQBt55B8dCsUquGd7WPfkpzGSY2vYLz
 XkzyFbz0nBEsKc+8L81aUu48=
X-Received: by 2002:a05:600c:c9:b0:406:4d8f:9fee with SMTP id
 u9-20020a05600c00c900b004064d8f9feemr19388852wmm.24.1697034041535; 
 Wed, 11 Oct 2023 07:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzXYpRVdRL+nmDI+YOxLq2nvfYQ2DWAJQMPhYn3ZLEmPStTWkSEUacw5SlJPG8kKza7H1iXA==
X-Received: by 2002:a05:600c:c9:b0:406:4d8f:9fee with SMTP id
 u9-20020a05600c00c900b004064d8f9feemr19388820wmm.24.1697034041070; 
 Wed, 11 Oct 2023 07:20:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b0040644e699a0sm19303923wmo.45.2023.10.11.07.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:20:39 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/9] tests/qtest: Introduce qtest_init_with_env
In-Reply-To: <20231006123910.17759-3-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 6 Oct 2023 09:39:03 -0300")
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:20:38 +0200
Message-ID: <875y3d9r61.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Add a version of qtest_init() that takes an environment variable
> containing the path of the QEMU binary. This allows tests to use more
> than one QEMU binary.
>
> If no variable is provided or the environment variable does not exist,
> that is not an error. Fallback to using QTEST_QEMU_BINARY.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


