Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 495BE718E63
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:26:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UFV-0004j5-Qc; Wed, 31 May 2023 18:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q4UFU-0004it-JK
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q4UFS-0002Ax-Rf
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685571893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1g+o53bzy95v8hNqIE/XgSYr21ZjqtZgtAQ5lsmeKo=;
 b=DNbvQ+B+bVSYiTUB5/THDNb3uTYU0w4tGy2G7NNPQXZ/Dl1z+iEJ7FIhFwyyPwhf9w/WI5
 19+lx8uno0/fpk1eB4Hvw0DxXkMmkTrdNHgYueigi46XaYe5WB10KzNygIHCp746cg0JMP
 y2skjOjBDWyHVlpn5Q6uQ8KHp3BhiuU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-0qf0xmgyP5qAHf4hBNzVjQ-1; Wed, 31 May 2023 18:24:51 -0400
X-MC-Unique: 0qf0xmgyP5qAHf4hBNzVjQ-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7776dd75224so24038139f.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685571891; x=1688163891;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z1g+o53bzy95v8hNqIE/XgSYr21ZjqtZgtAQ5lsmeKo=;
 b=OiZjxxKhu399dzVyn+X2TR2W2WJcIlSkczm3mpzYuuA2Kqst6Q2eycabHVvVFU+YpS
 RChvAlU5YsFIMsTQ7wRwgW56ygIxdT+cq0YKx8S29V1DEDC7vHdNEwCvKbJvMMnnuPz0
 HyTDC44ccCI9naKDZhaTXmRJt9MNx+zfPE/va5e3zu161MApkBzrFi9g7v6lpPOMGTrw
 6UX/MSwcFZNhJz31/knFLLcUeThurI72xpowq5QPpEJU2RQ9aQpJnCqS9zwVDzF1hIo0
 lPlx8pRP0/Z8Jyxam4d/eBGLxMhqwm13fk+CyzV8hQ3zJxaxS7QZCiL7LdTPUiSpnwjN
 2o6A==
X-Gm-Message-State: AC+VfDy84k+uXrTmqVw+Pzpsjb2hL2GtIUxgl8sTfQ6esW0f+6UGLufw
 fZ9iMkWMY+PYsdYoM19lQOWgLn3+c37QfNQsuO8KR0IZvFVVOpWdUd3Jppy2hLSLjUVu0q9tlJc
 87NKDEGGQwMLvvDI=
X-Received: by 2002:a5e:d512:0:b0:774:982e:cb0a with SMTP id
 e18-20020a5ed512000000b00774982ecb0amr5274493iom.15.1685571891193; 
 Wed, 31 May 2023 15:24:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6p4STuClohpN2ACTM0yw4wVJl2F0exFbyaIkgkYhqd0j10OwgfBCi0V+das4DwJ/rRSlAJgQ==
X-Received: by 2002:a5e:d512:0:b0:774:982e:cb0a with SMTP id
 e18-20020a5ed512000000b00774982ecb0amr5274479iom.15.1685571890960; 
 Wed, 31 May 2023 15:24:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 124-20020a021182000000b0041a84d0c828sm1814801jaf.87.2023.05.31.15.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 15:24:50 -0700 (PDT)
Date: Wed, 31 May 2023 16:24:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Voetter <robin@streamhpc.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org,
 clg@redhat.com
Subject: Re: [RFC PATCH v2 0/4] vfio/pci: Atomic Ops completer support
Message-ID: <20230531162446.2bc9a26c.alex.williamson@redhat.com>
In-Reply-To: <4301d6f4-a394-02e3-4773-823976b2e593@streamhpc.com>
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <4301d6f4-a394-02e3-4773-823976b2e593@streamhpc.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

On Wed, 31 May 2023 23:55:41 +0200
Robin Voetter <robin@streamhpc.com> wrote:

> Hi Alex,
> 
> Thanks for taking the time to implement support for Atomic Op completer
> support properly :). I have tested out these patches and the kernel
> patch, and apart from a minor issue with patch 2 everything works fine;

Yes, Cedric noted the extra semicolon as well, I'm about to post that
patch as non-RFC since it has no dependencies on anything else.

> ROCm programs that use device->host atomic operations work properly.

Great, thanks for testing!

> Something that I have been thinking about, are there any implications
> involved with enabling this feature automatically with no possibility of
> turning it off? I have no use case for that, though, and I cant really
> think of a reason other than preventing the guest from finding out
> hardware details about the host.

Not sure I follow, are you suggesting that Atomic Ops completion
support is proactively enabled in the VM to match the host, regardless
of attached assigned devices?  An obvious problem there is migration.
If I start a VM on a host with Atomic Ops support and want to migrate
to a host without Atomic Ops support, config space of the root ports is
now different and the migration fails.  QEMU would also require
elevated privileges to read config space to determine the host support,
and then what does it do if only some of the PCIe hierarchy supports
Atomic Ops.

Policy decisions like that are generally left to management tools, so
there would always be a means to enable or disable the feature.  In
fact, that's specifically why I test that the Atomic Op completer bits
are unset in the root port before changing them so that this automatic
enablement could live alongside a command line option to statically
enable some bits.

That does however remind me that it is often good with these sorts of
"clever" automatic features to have an opt-out, so I'll likely add an
x-no-rp-atomics device option in the next version to provide that.
Thanks,

Alex


