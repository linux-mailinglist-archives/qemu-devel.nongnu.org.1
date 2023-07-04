Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4411A747275
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:15:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfrx-0005rl-CL; Tue, 04 Jul 2023 09:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGfrw-0005rU-5X
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGfru-0005p1-MC
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688476497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HgU56Jb9oAALfA5DNLs9cSNt9PhE+0rEJU0KndMkfmw=;
 b=XTpq4y6nAWpvUBe2yNLOE7dYaCcE00kVmEGPXuUL88DNrzGEMkTB06Dv5JKC4QJFjLygXA
 ySk59tRw0kDIfjhmkZtF7TALuBUrbiUQwgve8g6/donicaI1WmzFvfwWS7dP9zLitTwou+
 hmFeCBl7SFte7wHkj6pXSX7Xi50Rp6k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-8-qujbm4Oiu8_kGdbOcj9A-1; Tue, 04 Jul 2023 09:14:56 -0400
X-MC-Unique: 8-qujbm4Oiu8_kGdbOcj9A-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4035b114793so22762111cf.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688476496; x=1691068496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HgU56Jb9oAALfA5DNLs9cSNt9PhE+0rEJU0KndMkfmw=;
 b=kESU6zYUUx07NN7Bs9YJ4b4QfpFKiczIIeVD37QqSyj8FMe4lskXxhQ2kbsRJy6Gk+
 qlR86BMnaiZEi9ve1aHf1WJHBBNgC0QpGBoR57kuUEtF6NrQLZFbcAXxG+BBlz7MftwK
 Dq1xkdx9wKk5gHPuYl1xJ0BiJaT/sXl9fzNPkdQQnlcSLI14Km+2qax20//E+Q5NmAIU
 AcNlV5/JG9z6RnRrepwpdvbCDz+ctrbM9STParez671HNhefH2Fw8xVhpi3C0RwALc7+
 ROj+G9rCOYXrrAjqYzPktELkpJe9P6nfbiMTeZUEPC3HEYXpx2ZMGpKZaLqX9JfI9sKU
 0ddw==
X-Gm-Message-State: AC+VfDz10CS8b/W1oTD+WMkY80so7hBkyOB9EmmvJ8ZMEHtI0Zo9wsnB
 8fuTBuR0U7rdJFx4MhQ1aWsljM7JC9KjralcQof/4Nk77EFRn5Nea9yLBLwmDtKZmlPzK7nJnhO
 q5dM0WAkHCw37SLU=
X-Received: by 2002:a05:622a:54b:b0:403:2066:fd4a with SMTP id
 m11-20020a05622a054b00b004032066fd4amr16238483qtx.33.1688476496075; 
 Tue, 04 Jul 2023 06:14:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60Hhv6E/D+lFNFeHht/lNY2cZw1ZCZ2ynIsM8esIAOxcMhjUvu2r7D4Ht4xPL8BLFjYp2gEA==
X-Received: by 2002:a05:622a:54b:b0:403:2066:fd4a with SMTP id
 m11-20020a05622a054b00b004032066fd4amr16238468qtx.33.1688476495803; 
 Tue, 04 Jul 2023 06:14:55 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-126.web.vodafone.de.
 [109.43.179.126]) by smtp.gmail.com with ESMTPSA id
 f14-20020ac859ce000000b003f9c6a311e1sm11131824qtf.47.2023.07.04.06.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 06:14:55 -0700 (PDT)
Message-ID: <3ea3a276-a06a-b1b3-bc88-662c94d240e0@redhat.com>
Date: Tue, 4 Jul 2023 15:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 14/20] tests/avocado: s390x cpu topology core
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-15-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-15-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 30/06/2023 11.17, Pierre Morel wrote:
> Introduction of the s390x cpu topology core functions and
> basic tests.
> 
> We test the corelation between the command line and
> the QMP results in query-cpus-fast for various CPU topology.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   MAINTAINERS                    |   1 +
>   tests/avocado/s390_topology.py | 196 +++++++++++++++++++++++++++++++++
>   2 files changed, 197 insertions(+)
>   create mode 100644 tests/avocado/s390_topology.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76f236564c..12d0d7bd91 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1705,6 +1705,7 @@ F: hw/s390x/cpu-topology.c
>   F: target/s390x/kvm/stsi-topology.c
>   F: docs/devel/s390-cpu-topology.rst
>   F: docs/system/s390x/cpu-topology.rst
> +F: tests/avocado/s390_topology.py
>   
>   X86 Machines
>   ------------
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
> new file mode 100644
> index 0000000000..1758ec1f13
> --- /dev/null
> +++ b/tests/avocado/s390_topology.py
> @@ -0,0 +1,196 @@
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# Copyright IBM Corp. 2023
> +#
> +# Author:
> +#  Pierre Morel <pmorel@linux.ibm.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +import shutil
> +import time
> +
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import exec_command
> +from avocado_qemu import exec_command_and_wait_for_pattern
> +from avocado_qemu import interrupt_interactive_console_until_pattern
> +from avocado_qemu import wait_for_console_pattern
> +from avocado.utils import process
> +from avocado.utils import archive
> +
> +
> +class S390CPUTopology(QemuSystemTest):
> +    """
> +    S390x CPU topology consist of 4 topology layers, from bottom to top,
> +    the cores, sockets, books and drawers and 2 modifiers attributes,
> +    the entitlement and the dedication.
> +    See: docs/system/s390x/cpu-topology.rst.
> +
> +    S390x CPU topology is setup in different ways:
> +    - implicitely from the '-smp' argument by completing each topology

implicitly

> +      level one after the other begining with drawer 0, book 0 and socket 0.

beginning

> +    - explicitely from the '-device' argument on the QEMU command line

explicitly

> +    - explicitely by hotplug of a new CPU using QMP or HMP

explicitly

  Thomas


