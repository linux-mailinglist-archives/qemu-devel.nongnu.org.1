Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2937970DD71
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1S2p-0001MR-Jv; Tue, 23 May 2023 09:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q1S2a-0001M4-Sl
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q1S2Y-0004kJ-NO
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684848419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xgcvjg4hufnLIXqzTyp1PTh7AC/3OnbOoYLqMEtCea0=;
 b=Hps+xn+8GWygD3lRxKk8agCRleCc1BGMNW4euSfAB7LQf3M7bM7kVJAP3wVTU5NZsVJ8gt
 NHXI83eUEi7tqh/nBFPrGNSC3imK8bw7CIoCEFJWUGnvI2ak1TV9BTpulL+Hsz0HQvdpJi
 pq9LhhvGvXE9UoAoNxs0OiE4bqjmXHc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-svCpGNpdMb6ReXWTJyn-9Q-1; Tue, 23 May 2023 09:26:58 -0400
X-MC-Unique: svCpGNpdMb6ReXWTJyn-9Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f698dea247so57976011cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684848418; x=1687440418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xgcvjg4hufnLIXqzTyp1PTh7AC/3OnbOoYLqMEtCea0=;
 b=FoB0ZZljboHa3tnMQEXiIwZWM6939dYsFyghhdlmwpoOXHg7ZLyuktfoHGJota4RzL
 j2BfKmMq12xRn56L6cLVf3a8gxLydXvGq0ry5MrLfeaOesetP3sZx8/7POioOibKLKoY
 Eoe8IrZcUHEQFosWO0GXMGU4g4IJe1XOW+RVoS5CxJN1RwDt6b4NdRcgNRX6TMoMrs+n
 kgDLAuiSM34O+9AIQG8rb9mGvOE7u2D3YroOULZQH0QiIK3v8SNYNnwikmEwdg0J5WLm
 QSQ6y3DycRmmAFKENv3mXod52O3hILXczYBahKK6yswPndK4YrshtD8gV13kKGVech8q
 79Ww==
X-Gm-Message-State: AC+VfDyHGHeWgLoq+JWhQl0v4AeKl+FhQzLxvg8n8KR/RmQqtPl9UABy
 ABgquESpI+ygXsDwDMRruf7r3likiMGPoGdAFD9oHTmfuLkOuoToz/U9FDEV4mvuyqIIdreZ9Nx
 ckxD4kHm7XDCcqqGk5cjGxLSMoPyWppNwfnKYYws=
X-Received: by 2002:ac8:5988:0:b0:3f6:9bcc:487e with SMTP id
 e8-20020ac85988000000b003f69bcc487emr17763263qte.48.1684848418053; 
 Tue, 23 May 2023 06:26:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51Y9cAgGqucv1W8s4ZiMllkg7v1I+Gu46r1zpPeHnr5bdo0ODgJOao0Qj8aKBRopHPuMJwkG6ME+hQjmCppV8=
X-Received: by 2002:ac8:5988:0:b0:3f6:9bcc:487e with SMTP id
 e8-20020ac85988000000b003f69bcc487emr17763251qte.48.1684848417880; Tue, 23
 May 2023 06:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230522174153.46801-1-cconte@redhat.com>
 <20230522174153.46801-4-cconte@redhat.com>
 <b87ddce3-a8cd-a725-7b7e-434ebfdba67f@linaro.org>
In-Reply-To: <b87ddce3-a8cd-a725-7b7e-434ebfdba67f@linaro.org>
From: Camilla Conte <cconte@redhat.com>
Date: Tue, 23 May 2023 14:26:21 +0100
Message-ID: <CACPOWh2W-W0FHtpbVud5UR-ZvDwcj3FH+47tfXkkpq8dc+8xaw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Add loop over docker info
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cconte@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Tue, May 23, 2023 at 2:06=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/22/23 10:41, Camilla Conte wrote:
> > +    - until docker info; do sleep 1; done
>
> How long are you expecting this to have to wait?
> Less than 5 seconds?

I remember seeing jobs where it took longer than five seconds, but I
can't find them at the moment.
I guess you wish the "until" loop to fail sooner, rather than having
to wait for the whole job timing out.
What about setting a five seconds timeout for the loop and raise it
later if we see
jobs failing?

>
>
> r~
>


