Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA787DCE67
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:58:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpFE-0003Go-K0; Tue, 31 Oct 2023 09:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxpFB-00031j-LB
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:57:22 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxpFA-00015c-8N
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:57:21 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso881442a12.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698760639; x=1699365439; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZjUwxjyHx9KtX1GXI5QXlRSXKtXVRqqvKShGXZBYCOY=;
 b=swMFesFl4iV4tqRg8o2SINk7hAr88UzCPJ+80OB2OwFyIFMrF9TMLvubfY1j519i5Y
 vJpU0CNh5KMNUZvoGtzVMYmHsEct14p022PPvq5ydzMmjp67X8Hga4jWK9E+tLETKhW5
 CZX5tXW/JLM7a47VTniQMuBjRjm+2H3K7eRrfZ3IIOi2cfm1LoHYTFYxnSB3/O9jeab/
 oLFiooOn402d3btjaKxPjzxW9trrI1O8i+rpfIanPrGcIMA2QMpAdKMaCHD8xvPRcpja
 pMcyeSXjVYCkYsFG7O+pUm8VMRNPefYeTrwqxlsTFLUYA4XSfIsedUS40Qyybjc8JsG3
 Mq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698760639; x=1699365439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZjUwxjyHx9KtX1GXI5QXlRSXKtXVRqqvKShGXZBYCOY=;
 b=Lxr5fK4EMAEnisp3bVdu0hMpyFdmB1VwFAI5KamFcqImL7rAhixoT+EzFE+TclffHf
 BrcPDCnRFXJTymMOZoBuI+TspD1EdPeL+4xyCZhp51ZP61GixoJKdHsTOOnJnQ8ygu70
 t1hRgm9FArG7feLODrRKIZRU5Dihd/6yEkk+xe7viNGH9SfVoftj5tCiSe57m0XxWOWj
 eRaslj+HUeSvq742fSYi6sQ+p0wsabQth7s+kIoHzee+S7SKKPfTEU/V0iXe6VVkNshd
 Tj+Cf3iEXLcuVTNyxQozuMUBMhJz4dNYQAvt9RUpqpiySEkeXzoWi/GRtEIDaEP+L7XX
 xHiw==
X-Gm-Message-State: AOJu0YxJ20eVSauy8797IVd8LmiCgbqJOh7IFj/KMScAI0Ms4/MbnfBH
 eRPxXD/iUdxaEs8iIfZ23qG6pgkJoBmtr9rp8XjiVUXoPz6bT+3h
X-Google-Smtp-Source: AGHT+IHMLd7GO5phsPcjdLzXmWmBk3f/L9UMppuyKFhvmkO8/3l/AE6TmAHsXU3PcOWgURPh+xLlyQvjKt1ulq9HAbo=
X-Received: by 2002:a05:6402:4305:b0:540:a5a1:745e with SMTP id
 m5-20020a056402430500b00540a5a1745emr12217559edc.14.1698760638814; Tue, 31
 Oct 2023 06:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_qBLXdeB7aQLcjcfMdEf9hpJu4ZhZZdHbF4SOSyZZXdw@mail.gmail.com>
 <04BA3ED8-5BD9-4E78-BCAF-DB8FCF6775FB@redhat.com>
In-Reply-To: <04BA3ED8-5BD9-4E78-BCAF-DB8FCF6775FB@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 13:57:07 +0000
Message-ID: <CAFEAcA-8W-ptoOOXd0jVNgYh5BmRq373wzBnQhU=XuEmRXwnpg@mail.gmail.com>
Subject: Re: tests/data/acpi/rebuild-expected-aml.sh creates files for arm
 virt that don't exist in git
To: Ani Sinha <anisinha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 31 Oct 2023 at 13:54, Ani Sinha <anisinha@redhat.com> wrote:
>
>
>
> > On 31-Oct-2023, at 6:38 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > I'm doing a patchset that requires rebuilding the bios-tables-test
> > expected-data files for the arm virt board. The instructions in
> > bios-tables-test.c say that you should run rebuild-expected-aml.sh
>
> This script seems to be only rebuilding the blobs for x86 and aarch64 not arm? So is it at all needed to run this?

I wasn't trying to be precise that I only meant 32-bit arm.
The change in question affects the 64-bit ACPI tables.

-- PMM

