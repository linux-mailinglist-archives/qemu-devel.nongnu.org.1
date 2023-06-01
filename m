Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E800719C1A
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:27:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hOj-0002rr-RC; Thu, 01 Jun 2023 08:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hOh-0002p1-43
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hOf-0001L5-Cx
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685622436;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKTWO+rvYFAnRi2NxkmZWiOUH34CH8BQLYPvmvrfxak=;
 b=jEWBY+Zy13oajyY4WUntiC/y78O3mKC0B03opsOHOtuld9K+Is1AJVkCaOWc9hiiV2tQwb
 iYoOKBhbEUSPFFA6i6FUjHvA7GGmqCB8j5Q6ZrCXQj6MqbfR/Nzu66xJlKXDAd0ql4SW30
 +QlaINSW/09KmYiAtPCLTyLa2NI7gM0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-ZutT1LWVMU2iHiAMfz-s2Q-1; Thu, 01 Jun 2023 08:27:15 -0400
X-MC-Unique: ZutT1LWVMU2iHiAMfz-s2Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f495fc7a43so839761e87.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685622433; x=1688214433;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gKTWO+rvYFAnRi2NxkmZWiOUH34CH8BQLYPvmvrfxak=;
 b=JP0ROEBS09O603Phq6TcgDPP0maMEsROs8lRAemaSfHd3W1qmcpKVFYfW/IisxC2hw
 JBqH9u39K8VV6NDsiOZ55Fa6VsD8Ai8bCxNJduNIWwfG1th1AcPKejfdRjguJyVPoZuK
 as47DW24qNLroBHL4h7T7rZRBRPhp6dSM8JGR+mwDZWv4QOLFJTfguybgEm9IVeLJfh5
 Iupfeoew8QBPZlHI/BhXo9v0DMU7JtPzIQbkEVmOjzvS+r6G5dt3D+Tf+vMwPFztnSSs
 ZTNyEKU/uS+GYo55RGsoNrlK4mzoC30spCoql5eFeaDl2IF5uxfqKxiPgxmPc7CyfDTP
 UpyA==
X-Gm-Message-State: AC+VfDwSTMM2558gPJHCZncgEMtVEHmX+ZXnrS7e5qWUX7NXNT63+3IQ
 sVprLTK35uh0CuCjZuQGz28ohsavD4zQMl0VP0qjouWOs8e2qDBKTPchtdH9MZbglXvKrZCt3KM
 8D+qOerHut+nEqn0=
X-Received: by 2002:ac2:5d52:0:b0:4f3:a820:dd98 with SMTP id
 w18-20020ac25d52000000b004f3a820dd98mr1136890lfd.7.1685622433669; 
 Thu, 01 Jun 2023 05:27:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eOIRXB0wlNUfrz4NBrfluQFrDxav2zGKdW+MxR4VV7x8mf2Uo7Z+fwVcB11nM7ANH4RFlQA==
X-Received: by 2002:ac2:5d52:0:b0:4f3:a820:dd98 with SMTP id
 w18-20020ac25d52000000b004f3a820dd98mr1136874lfd.7.1685622433346; 
 Thu, 01 Jun 2023 05:27:13 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c040c00b003f6f6a6e769sm2234906wmb.17.2023.06.01.05.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:27:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 6/9] tests/qtest: replace wait_command() with
 qtest_qmp_assert_success
In-Reply-To: <20230531132400.1129576-7-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 31 May 2023 14:23:57
 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-7-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 14:27:11 +0200
Message-ID: <87ilc7s6zk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> Most usage of wait_command() is followed by qobject_unref(), which
> is just a verbose re-implementation of qtest_qmp_assert_success().
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>



> -    qobject_unref(rsp);
> +    qtest_qmp_fds_assert_success(to, &(pair[0]), 1,

I was wondering about the parens, and then saw Thomas message O:-)

Later, Juan.


