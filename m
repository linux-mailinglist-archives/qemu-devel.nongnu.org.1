Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B67CF7B8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRey-0007Kr-Iw; Thu, 19 Oct 2023 07:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRew-0007Jv-KR
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRev-0007L8-2k
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697716668;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=knRh9ausW9Yco1S/La/mUIZuDxb5hui2n5SC8mwSfII=;
 b=Q85hhWyP+EGcfVXqf9Tv1Zg1WMRX7FyED07Qw9IIxvgEDxAj71/BtasEEb6iZNMZaTdy2I
 XBz8RW7e9YqHTKDORkAHkfVV4eLyqA0XWa1fwcrEDiO7KJ8mye6IUIjCKWGMYPaS1HcG0H
 ARrB3FdRt183XfVpW6yhZEXxZs9zrd8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-WyVl6f9RP_GMQB00JVTkhQ-1; Thu, 19 Oct 2023 07:57:47 -0400
X-MC-Unique: WyVl6f9RP_GMQB00JVTkhQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso9658245e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697716665; x=1698321465;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knRh9ausW9Yco1S/La/mUIZuDxb5hui2n5SC8mwSfII=;
 b=nTj8/JC7iZSYTx8nrpqdsTz85+Ae0hQ/3OPy3kpDPE++PSPAO+QKXD+e4RW/mvFDO3
 44OxGljqp8iZoVaeBwlophNWCrd9lfv/w2qTWGhF5PKHIgCTjxM750slrJBcNqTfX761
 GaRqjoZhAxHgYClWT2X1yH5nGlc9urdLkxdzYa3Rz5jFNyVO8AelxBgyhfXYWyXSQ3bR
 U+57JpF/WvDc1YIfqt1s3y98FEUg3wZ8ysKH1hN93/ZUcgrgrhMIfWBbLLKHHARVQ8Sk
 1FxaCisETWjcCoWzK9/CU2Z6s6uqPTbr1IB2rMRC3+S7IFzIAEzKSMiHNf2hXE25q/n4
 t1Fw==
X-Gm-Message-State: AOJu0Yww0hP0fDk3plyxrlFXWqM3XPNATYsthVhhwaUvcmckmhhnIvdy
 aLdlJUS2PJj0EMmRYqvtj1dVQ53Qpih79JNbcQ3dpteJGYR2sINRZu2DVTpAgj6xcyv2p/XernX
 76r5lwb2l7z/aE6dfQ1BjErCRbQ==
X-Received: by 2002:a05:600c:4715:b0:405:39b4:313e with SMTP id
 v21-20020a05600c471500b0040539b4313emr1564785wmo.13.1697716665675; 
 Thu, 19 Oct 2023 04:57:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3gPVo/okq5e/qx7h9ylyqUTs3SOh/l5t/1Q/VMUL7UU02DsCUWHJp6ZoO7FK6DC2zLBl5lA==
X-Received: by 2002:a05:600c:4715:b0:405:39b4:313e with SMTP id
 v21-20020a05600c471500b0040539b4313emr1564774wmo.13.1697716665328; 
 Thu, 19 Oct 2023 04:57:45 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m36-20020a05600c3b2400b00405bbfd5d16sm4328963wms.7.2023.10.19.04.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:57:44 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 07/12] tests/qtest/migration: Define a machine for
 all architectures
In-Reply-To: <20231018192741.25885-8-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 18 Oct 2023 16:27:36 -0300")
References: <20231018192741.25885-1-farosas@suse.de>
 <20231018192741.25885-8-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 13:57:44 +0200
Message-ID: <87zg0e4yfb.fsf@secure.mitica>
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
> Stop relying on defaults and select a machine explicitly for every
> architecture.
>
> This is a prerequisite for being able to select machine types for
> migration using different QEMU binaries for source and destination.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


I have patches to simplify this, but will rebase on top of yours.


