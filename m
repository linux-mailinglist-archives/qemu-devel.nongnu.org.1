Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B409771F638
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4r5Q-0004e9-RK; Thu, 01 Jun 2023 18:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4r5P-0004dy-13
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4r5N-0005Qw-IJ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685659680;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZjIpnOon0H42FrJS3KciwL+KFq1vJIcS5Kj0/cd8xs=;
 b=W3dnGa0kBEITBfgU46QJtkfsZwyOMGGsD+V60j6ic0QEucR/TdN675Yt3QH/c7aoSCjXRa
 U/aiDufgYTsZPLN44I7IKvhkICsz1BrYXKfwIETC1QobW25UwiSEPcc0TBHkiRXy0PDsRX
 qEriemYxIuom5VS/1X/7kbk/+HLt1Q8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518--YohJLxwOkGOS_DG0fEFOA-1; Thu, 01 Jun 2023 18:47:59 -0400
X-MC-Unique: -YohJLxwOkGOS_DG0fEFOA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f495fc7a43so1363477e87.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 15:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685659677; x=1688251677;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NZjIpnOon0H42FrJS3KciwL+KFq1vJIcS5Kj0/cd8xs=;
 b=GQdLh3xW3N7M5hVdjS2SdF7Dsg6Vdyhi3vT5BS2kd96QGGyjfdyS0Iz844EhZre9fl
 DzJDQObhoj8P6tydDfb8D3yQ3LwSna4/T9qrdnpW6wbCp0dv0S++KZhiL+IqjKDJ9czt
 0P6EXvvo692Pub5CBzB+pplQ5XkQGDmG34QGj+ItTWIzMiofQZ4jD7x8UcZDPrTidoLh
 UfB4FzHWWL2VVBBUnHp+EafCYWRwN5mugr/iMz+ox3UhCxF5Uh1pEOWtQcy2tI7K1H4K
 HwFE/FINa8f5o9nOqWJzY8P8pOj4u4uXs8RoIK4NWbU9aej8W4jqvvRNTlHd6Q9ux/CW
 XX6w==
X-Gm-Message-State: AC+VfDwIXpSTHX24m4081N1Lewyc/SmYNXSNact7zZt1L7ADoG2BUQf5
 IgOkiBcaqa0gb9pxoZWjdTLZYvAZUwSoyVGgeizH21P0/vwnhA5/qkgFZuXpw6LIa4atlGWc9ge
 jYyMrfMYH2xA1FAE=
X-Received: by 2002:ac2:455b:0:b0:4f3:a554:a7fd with SMTP id
 j27-20020ac2455b000000b004f3a554a7fdmr695365lfm.40.1685659677589; 
 Thu, 01 Jun 2023 15:47:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6s8GyHE9OyIg/gM4TvSKwtwB4l8UUr3Kgnv6AeD5Jt6XHDENLWJ9s6njVdLNRiEPZArGROfA==
X-Received: by 2002:ac2:455b:0:b0:4f3:a554:a7fd with SMTP id
 j27-20020ac2455b000000b004f3a554a7fdmr695356lfm.40.1685659677228; 
 Thu, 01 Jun 2023 15:47:57 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 t3-20020a1c7703000000b003f603b8eb5asm59832wmi.7.2023.06.01.15.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 15:47:56 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v4 08/10] tests/qtest: distinguish src/dst migration VM
 stop/resume events
In-Reply-To: <20230601161347.1803440-9-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 1 Jun 2023 17:13:45
 +0100")
References: <20230601161347.1803440-1-berrange@redhat.com>
 <20230601161347.1803440-9-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 00:47:55 +0200
Message-ID: <87o7lyre90.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
> The 'got_stop' and 'got_resume' global variables apply to the src and
> dst migration VM respectively. Change their names to make this explicit
> to developers.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Reviewed-by: Juan Quintela <quintela@redhat.com>


