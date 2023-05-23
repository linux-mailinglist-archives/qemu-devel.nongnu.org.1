Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAF870DD78
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:30:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1S4x-0002iA-Km; Tue, 23 May 2023 09:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q1S4v-0002hG-UD
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q1S4u-0005G4-5J
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684848566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyCdXYibxUkX/beXDihLMf9mHmrDiwgv9yPGoFZ+jBs=;
 b=VJ42HVkzS3q23g+5rageAsSwFiwY8hs+b0FMkVzRAX91QrzpRxJc+iySY7+1moohe60gOL
 KRnTGkpgkHn+ehM7yWMtf8pXE7GYy+ejXBH1BUlOaifpue8hUwv1lFkygy653Zjcf4hCPh
 5oK43HBtiVM61APt9mG6nfqDl4anJoc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ZvDKrEY0NxK5DRUPhhvHVg-1; Tue, 23 May 2023 09:29:25 -0400
X-MC-Unique: ZvDKrEY0NxK5DRUPhhvHVg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f6ab996ea3so35469741cf.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684848564; x=1687440564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyCdXYibxUkX/beXDihLMf9mHmrDiwgv9yPGoFZ+jBs=;
 b=WMGK0LpwouPtyrKbsULt1+e4tXjGaIwqJ0qD4ngzUqOFWAfcre43C77SjdQqyR4O3f
 QAVEIxF7iBnQQpsVxb7eMQ7ou8JRYxrl72vFIf3DRvYrr1di4/N8Q4hoTYA6TKY1KeTM
 d7hugb/EcOKrY2KmMHRYcR7v/A6u6VLHoZcvTAdhe2vu986E/WI1XQr/2Xk38Lm1rvQI
 H4aDvyQzmIHYVG//hvTMCxAHn66j86/PQmf/UQOmuLE/S0KdPutSaB4BNLB0snCqVLvw
 BpvQRvqi5bKQJ62N+qm5Y/dVbiRcdG2Gwdg/4otCrn/+ONl9c0XvLlsCf0jwa1SDoPu+
 nyVw==
X-Gm-Message-State: AC+VfDxARoa66zOeF8FpKtkEdvmjApbwDTBNYbdE9Xz27Z002ub2JydL
 Ki7dpAJqYD8++LPDMHhfy7HNNN6k1aR2QVZDNCFx2m8lX5ej74nA1hXOgYB/7xE6rsz47OXnpQV
 ELCVaWg9QlsT1RJXkKwhM/sinSZ5rmkU=
X-Received: by 2002:a05:622a:452:b0:3f3:8749:741 with SMTP id
 o18-20020a05622a045200b003f387490741mr22168399qtx.13.1684848564717; 
 Tue, 23 May 2023 06:29:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lJDqRot8uplacr2QkDUIWNbmuGwrzHZi4mTGVx42S+0jehOo0PlDSV9l8gwhc7qwUITB/k6GG8giKQIt73NY=
X-Received: by 2002:a05:622a:452:b0:3f3:8749:741 with SMTP id
 o18-20020a05622a045200b003f387490741mr22168379qtx.13.1684848564456; Tue, 23
 May 2023 06:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230522174153.46801-1-cconte@redhat.com>
 <d08d55dd-f38b-063c-d64e-9a0f79dbebf9@linaro.org>
 <CACPOWh0w=YEeGgG8rc1C-fOmfvRwVo4NVTqjARRwZNWEPjZehQ@mail.gmail.com>
 <b30f4f2e-5784-5c7b-8f13-aa12c61bae23@linaro.org>
In-Reply-To: <b30f4f2e-5784-5c7b-8f13-aa12c61bae23@linaro.org>
From: Camilla Conte <cconte@redhat.com>
Date: Tue, 23 May 2023 14:28:47 +0100
Message-ID: <CACPOWh3-_=gkg0CxD=FFvCjTJAmcuTRuVh_YEdn1BXRJc-qxUg@mail.gmail.com>
Subject: Re: Add CI configuration for Kubernetes
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

On Tue, May 23, 2023 at 2:08=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/23/23 01:24, Camilla Conte wrote:
> > On Mon, May 22, 2023 at 11:52=E2=80=AFPM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >> This does not work:
> >>
> >> https://gitlab.com/qemu-project/qemu/-/pipelines/875254290
> >
> > My bad, sorry. I didn't update the runner with the new values.yaml.
> > The Docker environment variables were missing so it's looking for the
> > Docker server at the wrong place.
> >
> > Now I updated the runner. You have to add the "k8s" tag to the runner
> > again in the settings:
> > https://gitlab.com/qemu-project/qemu/-/settings/ci_cd#Runners.
> > As soon as the "k8s" tag is there the pipeline should be able to run.
> >
>
> The k8s tag has been there on the runner all along.  Did you mean somethi=
ng else?

I had Paolo adding it a few hours ago.

>
>
> r~
>


