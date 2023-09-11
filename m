Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0A79A7FB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 14:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfgE2-0003sn-Oe; Mon, 11 Sep 2023 08:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qfgDw-0003qn-Qw
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qfgDu-0004zK-IB
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694436061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rt9y7mfa3TmZh8nuHjvhu5+sa8ZlQmLwB4T6vMeIi0M=;
 b=Bmml/hxzOyoBJKyJ3u6xr7Ray8yTRm7m3bEKiCpP6x+QiKcUjIbzMQgblfI+gDDejcx13v
 md6h/yDstUhPXlkBevY7NjXcOUcz7xOkvGsRuOEQfO/+FaRBZ7DyLNXEOCYU4/ma2Zg5tV
 hWgLN6sDXpLPQDlXEglULqzSPMwWCWs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-6oBUYtYiNLuEIg17Dkd8fA-1; Mon, 11 Sep 2023 08:40:59 -0400
X-MC-Unique: 6oBUYtYiNLuEIg17Dkd8fA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63d0c38e986so44404856d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 05:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694436059; x=1695040859;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rt9y7mfa3TmZh8nuHjvhu5+sa8ZlQmLwB4T6vMeIi0M=;
 b=cobmQ2jsuY2DzpWYlzuQ3FSgMK1dlEZS8cHgVQx+vdL626VLJK85ZGufLa+h++pZU7
 DGLiozjUUnsB2PUWFzNo619DIKRROkcgoXX1Hhit6ic803iIMkBjcf4s7qGIIMFk0OC3
 039mlFewJ16mFFQuYrqL3JhwHF42SThzgEdXsbWqiMqF5vxjNQ8WaLiEeUOf8XBrUc3B
 fHuubounq5t+E4vqX4mO9VfVmq6Q2GB22scJrczRTOahqLBMrtupqU4cFburcVqbD0kr
 FjZgRGJ0IhKOBaJAR5VIa5aTHsw0AoUVk3N41LqTXT8Fn4KlunGgNoxxg436Y/UJVg8X
 Bo6Q==
X-Gm-Message-State: AOJu0YwAhBvkNeslmSYM0l8a0C4Ok1WGjTdjZtC+x2SbIrPplySZHUqz
 htrW4vs7036rsGeYzgX/Hp2bEJg/YuF0zyx89UC/RyA/HlU8VwshjdmjHb69rdQ0g/AxufvCIfV
 ujtmLRGFkNTaoPjA=
X-Received: by 2002:a0c:f3c3:0:b0:655:de6d:f0be with SMTP id
 f3-20020a0cf3c3000000b00655de6df0bemr4346756qvm.55.1694436058861; 
 Mon, 11 Sep 2023 05:40:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD7+wvjDfZPdrtrIidgf7b0uugk9igAMTXqt9xH2Twlfa35ecFTfnPJR9EyIImixVrlcBNRA==
X-Received: by 2002:a0c:f3c3:0:b0:655:de6d:f0be with SMTP id
 f3-20020a0cf3c3000000b00655de6df0bemr4346739qvm.55.1694436058599; 
 Mon, 11 Sep 2023 05:40:58 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-178-150.web.vodafone.de.
 [109.43.178.150]) by smtp.gmail.com with ESMTPSA id
 x18-20020ae9f812000000b00767da10efb6sm2476398qkh.97.2023.09.11.05.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 05:40:58 -0700 (PDT)
Message-ID: <f6f8ede568f2eda680fbc69ab7e45a61f3c18058.camel@redhat.com>
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Mon, 11 Sep 2023 14:40:54 +0200
In-Reply-To: <CAJSP0QWAzj9G=xzzXyzmTdXNWMfySyuZGpgpj5w32-5ML3mYJQ@mail.gmail.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <CAJSP0QX4QgxG-3dbv6oa6_81MWJkYKTT7T05D5hCtFiG=mLi7Q@mail.gmail.com>
 <93be81d9-3f96-51e2-4b20-74ce99e56ae1@linaro.org>
 <CAJSP0QWAzj9G=xzzXyzmTdXNWMfySyuZGpgpj5w32-5ML3mYJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 2023-09-11 at 07:06 -0400, Stefan Hajnoczi wrote:
> On Mon, 11 Sept 2023 at 06:10, Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >=20
> > On 8/9/23 17:47, Stefan Hajnoczi wrote:
> > > I wonder how it passed CI?
> > > https://gitlab.com/qemu-project/qemu/-/pipelines/996175923/
> >=20
> > The conditions are:
> > - x86 host
> > - both system / user emulation enabled
> > - KVM disabled
> > - debug enabled
> >=20
> > We have jobs with 3 of the 4, but none with
> > all the 4.
> >=20
> > Is it worth test it?
>=20
> I think so.

Would it be feasible to modify one of the existing jobs instead of
introducing more load to the CI by adding yet another new job?

 Thomas


