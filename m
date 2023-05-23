Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A970D765
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:26:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1NKw-0007DH-Gs; Tue, 23 May 2023 04:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q1NKr-00076G-R2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q1NKp-0006kV-Ui
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684830334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itEPe2U3Rh9y2iF9u4odgblHLa1Yw1FoIVlUlNfR4WY=;
 b=VG+1lcAlM1ZWLNH/ULY7GQNRCWp373oNShPVwiiVKu1CXtYcVaoVLFZPDbPAsXY3wh2mTi
 pO6gp8+LHotMjHg/RVgme0K2yUAgbG7eu9Nwq70jYZLEA5NrA2hixGMgzXAFyeHXM1Twc1
 9Mu599qviGUxveDASKDDcqElF3ye5mM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-6V-MuU_BOPq3k2a4SIm1Rw-1; Tue, 23 May 2023 04:25:32 -0400
X-MC-Unique: 6V-MuU_BOPq3k2a4SIm1Rw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6238a4e544bso45551776d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 01:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684830332; x=1687422332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=itEPe2U3Rh9y2iF9u4odgblHLa1Yw1FoIVlUlNfR4WY=;
 b=jD53XtoVDAdIDdTdjJMfL3cYWOCxIQsNubYGJoXcQP9pD9zMR8HGcdc2L3CMuEJRuN
 NG1yJIDEi4A63kriC0ceaCVPIIwjkz7NJ3ic5eLV0UKjLfQrwVxbCEKkzB5EIY1wQjIm
 6L6oDYl4L/dLwch3IrjSOkSKgdQEUeursmxvh8qLsYXnCzlSCidjMdTne8YMv3dogzYn
 q3acwOpkqJXDN/63CmJdDe6R2AHb6Q422FbZNWFubgBcvbQWOaYCXB4VL1Up0050W03B
 IEcPsFHcXdkPepDPG6KVGPEfXsHnzTequDEW1qNRR4Q6F255cyA3tNKC2znizikDFoin
 ZLZA==
X-Gm-Message-State: AC+VfDwP5tPyNjI08E8bgdSuJro5a2DbCMUL2/SXLa5DQ1/516NX4bIK
 5kN42oCLA3UYIzLz/QUJx9gi0/JAUIDk7I8qobtfqDUgQePB05VYXkZPnMEfPWiR3V23l107eUT
 ssOCuYhYm+vZg79rtfQgcZha13Tzo60U=
X-Received: by 2002:a05:6214:19cd:b0:61b:5cba:5820 with SMTP id
 j13-20020a05621419cd00b0061b5cba5820mr21773591qvc.50.1684830332432; 
 Tue, 23 May 2023 01:25:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TFOHbH3zzmALgZSD4NUixM0rI+h7Ol6OTIiG9GQ6m3KL+RQkq+xM/kY+t/mBlGRb+xvFLyYKgnmnuTKavaNw=
X-Received: by 2002:a05:6214:19cd:b0:61b:5cba:5820 with SMTP id
 j13-20020a05621419cd00b0061b5cba5820mr21773584qvc.50.1684830332213; Tue, 23
 May 2023 01:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230522174153.46801-1-cconte@redhat.com>
 <d08d55dd-f38b-063c-d64e-9a0f79dbebf9@linaro.org>
In-Reply-To: <d08d55dd-f38b-063c-d64e-9a0f79dbebf9@linaro.org>
From: Camilla Conte <cconte@redhat.com>
Date: Tue, 23 May 2023 09:24:56 +0100
Message-ID: <CACPOWh0w=YEeGgG8rc1C-fOmfvRwVo4NVTqjARRwZNWEPjZehQ@mail.gmail.com>
Subject: Re: Add CI configuration for Kubernetes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cconte@redhat.com;
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

On Mon, May 22, 2023 at 11:52=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> This does not work:
>
> https://gitlab.com/qemu-project/qemu/-/pipelines/875254290

My bad, sorry. I didn't update the runner with the new values.yaml.
The Docker environment variables were missing so it's looking for the
Docker server at the wrong place.

Now I updated the runner. You have to add the "k8s" tag to the runner
again in the settings:
https://gitlab.com/qemu-project/qemu/-/settings/ci_cd#Runners.
As soon as the "k8s" tag is there the pipeline should be able to run.


