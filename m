Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DA97C569A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:18:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa1i-0008EN-Kx; Wed, 11 Oct 2023 10:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa1g-0008E2-SS
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa1e-00016A-Bj
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697033844;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7rF2HIKIJNWULyLFbotYhTY+EVTRl9bAsGTJSL4Pf1I=;
 b=eI+mSpuA87S5ftQb+QaiWgrp0TpWqCnafHMWQ6djJILtB9GHZcW8gCcA+3ZLIZxYk1FOax
 OTe03f4NAPBYJ4+3UW6+xficGcGAqK+7RQ3+756aAXbWjwQU4H2aWFwtbvXMNeblccsuQJ
 wKcGpTsBnEpTf2KJXHKgCFPRBG6UGIo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-1wGtAdC9P2qwyTqrpYdzrg-1; Wed, 11 Oct 2023 10:17:22 -0400
X-MC-Unique: 1wGtAdC9P2qwyTqrpYdzrg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d58708cd5so1022373f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697033841; x=1697638641;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rF2HIKIJNWULyLFbotYhTY+EVTRl9bAsGTJSL4Pf1I=;
 b=g2/f6/GWCifZRbyTK15ub+rU+jsZ5j4upWIUg/RsyOoz7s3lxaKY5BUK+w0yQ05aDj
 9/TsUHGZlOpHtyG36Cz4XS1ObSijZwMYP9rqmxC2ttUPhV8UfUfKJp8Nub8guveRAIkd
 QsZ4WB08g+xRWz3pr0AYBWt1kZedv6n3gGXAvlzgpn5efoTjOviD+MQvP4gWGYMYwYaG
 jrZ8AtLWkDT/Zvqy9eThElnEsNcvllf2E2KqilBrBd1RfrKx+jVpdNsv1U0lQHJTwb3G
 ws+8oIgEegpTGW4kH4LliihKdwT4JORuOuVd0ABbNf9a4dFgs/M9XQtUwVsuD6JWFFHP
 +GwQ==
X-Gm-Message-State: AOJu0YyDYFNM0zxekCXfx2GSK85IQKTKn3Hdz5PfBzT8a261FYO3Dabo
 5dHuu4p0FOWslnmbSwIB9VmFi65tY22HplDbaGzltRmyEZpn16hdyW1NFkHz0ovWcJo+W7QjrYK
 GRYwHvOS8dakcoLc=
X-Received: by 2002:a5d:664a:0:b0:31f:fa38:425f with SMTP id
 f10-20020a5d664a000000b0031ffa38425fmr20636821wrw.9.1697033841733; 
 Wed, 11 Oct 2023 07:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE76/77x7jGLHGx29AgZ80OwvNv3g3TOd+f06SVy9BkzryP0astylN9r8qxJj0Fw0sJixSncw==
X-Received: by 2002:a5d:664a:0:b0:31f:fa38:425f with SMTP id
 f10-20020a5d664a000000b0031ffa38425fmr20636802wrw.9.1697033841416; 
 Wed, 11 Oct 2023 07:17:21 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s11-20020a5d424b000000b003248a490e3asm15658494wrr.39.2023.10.11.07.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:17:20 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/9] tests/qtest: Allow qtest_qemu_binary to use a
 custom environment variable
In-Reply-To: <20231006123910.17759-2-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 6 Oct 2023 09:39:02 -0300")
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-2-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:17:20 +0200
Message-ID: <87a5sp9rbj.fsf@secure.mitica>
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
> We're adding support for testing migration using two different QEMU
> binaries. We'll provide the second binary in a new environment
> variable.
>
> Allow qtest_qemu_binary() to receive the name of the new variable. If
> the new environment variable is not set, that's not an error, we use
> QTEST_QEMU_BINARY as a fallback.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Thomas, do you want me to get this through the migration tree?

I will wait for you ack anyways.


