Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DBF7427B0
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEs04-0004Mv-8q; Thu, 29 Jun 2023 09:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErzz-0004J5-0y
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:47:51 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErzw-00053H-Ao
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:47:50 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-314118623d5so770001f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688046466; x=1690638466;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RgHBCTOZO+tsQXHbUlw+ekEZk3CFfzrY/uYx6B7yJU0=;
 b=Ec3Rz2e0oPGqq/UnhOvufLDcBMRkaU3HAaUPmP5Uoyx8JejiROvn3003XTEccuT17K
 BaUUTNNiyAs9mn80/CVBeJx3+pOIfp2EYDPC/25xGBoVSybUMrre6QOwzTBBlI+rJM8Q
 0PJxckD0t2cYPu5Na5HlG/co2gF54NUHSgOX/SPrJjABKJWZux3sJcacuMSbUKoLocha
 afCs7cp0tCK5Je9hzz8LWbKmcrzfISMAeH4Nlt/vOpZZ6TL3SiPuyZobEjOye55K/tCa
 R0z2BEQLJFR+NsrTNmCdXX3DdS9eiff97657rYg9xv0YzW9lkmAUHBCCYVmiHfBbRMAs
 FGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688046466; x=1690638466;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RgHBCTOZO+tsQXHbUlw+ekEZk3CFfzrY/uYx6B7yJU0=;
 b=lPt9AO12abeKA+LEmyemdZ1UMJvLXa7nM0R4yHi8UwSU4RpsO/4nAoLQPvYvxuhFmv
 rNLaTQGiCc7GPvco/QLrUjA6sr7y8sfIH7JQQVcFUH6VfGFgcYSKaJhTDYNLHvvMoFCw
 sw34tBOU8Vwe3++dxO0vCcedTncOQLYhJ6r/tjjQGo8s+zBUt+ze78L3TRJG0vVl/LtP
 OvM0Sy1iZXvZUZChdbCs6PY9HZRu5JQB3Y0dnR/+OWZst4dtThbXPbyJAQrjYMQXGKwA
 WRpPALBs25meOyLkTfu15hdO/d2WaSwpUGXuLLnu7mL41ThGLXBbzMhekScZ0uhGrVhy
 qAVA==
X-Gm-Message-State: AC+VfDzGltpQlN9N0oisUio3uLzE7YedyJRniaONm2TpoZLXcTt+loxW
 +XVbu2lbjO9PDEK0lzRWRqbuTQ==
X-Google-Smtp-Source: ACHHUZ4n2wreHUXBGq0DbojpgB5EXbH+jIpS9bIRKWs4AI8Gd/mG9m6YL+rWqJ3KO0CbFXOG4N6fJg==
X-Received: by 2002:adf:eb51:0:b0:30f:b341:79ef with SMTP id
 u17-20020adfeb51000000b0030fb34179efmr28624827wrn.71.1688046466523; 
 Thu, 29 Jun 2023 06:47:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 j4-20020adfea44000000b0030fa3567541sm16014393wrn.48.2023.06.29.06.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 06:47:46 -0700 (PDT)
Message-ID: <dc6a61da-73d0-d0ae-fc62-3a04ccea5417@linaro.org>
Date: Thu, 29 Jun 2023 15:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] hw: Simplify calls to pci_nic_init_nofail()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20230629125449.234945-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230629125449.234945-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

Hi Thomas,

On 29/6/23 14:54, Thomas Huth wrote:
> pci_nic_init_nofail() calls qemu_find_nic_model(), and this function
> sets nd->model = g_strdup(default_model) if it has not been initialized
> yet. So we don't have to set nd->model to the default_nic in the
> calling sites.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/arm/sbsa-ref.c        | 8 +-------
>   hw/arm/virt.c            | 8 +-------
>   hw/loongarch/virt.c      | 8 +-------
>   hw/mips/loongson3_virt.c | 8 +-------
>   hw/xtensa/virt.c         | 8 +-------
>   5 files changed, 5 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index b774d80291..d8e13ddbfe 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -683,13 +683,7 @@ static void create_pcie(SBSAMachineState *sms)
>       pci = PCI_HOST_BRIDGE(dev);
>       if (pci->bus) {
>           for (i = 0; i < nb_nics; i++) {
> -            NICInfo *nd = &nd_table[i];
> -
> -            if (!nd->model) {
> -                nd->model = g_strdup(mc->default_nic);
> -            }
> -
> -            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
> +            pci_nic_init_nofail(&nd_table[i], pci->bus, mc->default_nic, NULL);
>           }
>       }
>   
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3937e30477..b660119bce 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1477,13 +1477,7 @@ static void create_pcie(VirtMachineState *vms)
>       vms->bus = pci->bus;
>       if (vms->bus) {
>           for (i = 0; i < nb_nics; i++) {
> -            NICInfo *nd = &nd_table[i];
> -
> -            if (!nd->model) {
> -                nd->model = g_strdup(mc->default_nic);
> -            }
> -
> -            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
> +            pci_nic_init_nofail(&nd_table[i], pci->bus, mc->default_nic, NULL);
>           }
>       }
>   
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index ca8824b6ef..51a453fa9a 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -547,13 +547,7 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
>   
>       /* Network init */
>       for (i = 0; i < nb_nics; i++) {
> -        NICInfo *nd = &nd_table[i];
> -
> -        if (!nd->model) {
> -            nd->model = g_strdup(mc->default_nic);
> -        }
> -
> -        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
> +        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
>       }
>   
>       /*
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 216812f660..3dd91da7a6 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -454,13 +454,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
>       }
>   
>       for (i = 0; i < nb_nics; i++) {
> -        NICInfo *nd = &nd_table[i];
> -
> -        if (!nd->model) {
> -            nd->model = g_strdup(mc->default_nic);
> -        }
> -
> -        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
> +        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
>       }
>   }
>   
> diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
> index b87f842e74..a6cf646e99 100644
> --- a/hw/xtensa/virt.c
> +++ b/hw/xtensa/virt.c
> @@ -103,13 +103,7 @@ static void create_pcie(MachineState *ms, CPUXtensaState *env, int irq_base,
>       pci = PCI_HOST_BRIDGE(dev);
>       if (pci->bus) {
>           for (i = 0; i < nb_nics; i++) {
> -            NICInfo *nd = &nd_table[i];
> -
> -            if (!nd->model) {
> -                nd->model = g_strdup(mc->default_nic);
> -            }
> -
> -            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
> +            pci_nic_init_nofail(&nd_table[i], pci->bus, mc->default_nic, NULL);
>           }
>       }
>   }

This remind me of a branch from end of April with this
unfinished patch, did we already discuss this together?

-- >8 --
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6d0574a29..6bb02dc64f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -317,6 +317,9 @@ void pci_device_reset(PCIDevice *dev);
  PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
                                 const char *default_model,
                                 const char *default_devaddr);
+PCIDevice *pci_nic_init_default(NICInfo *nd, PCIBus *rootbus,
+                               const char *default_model,
+                               const char *default_devaddr);

  PCIDevice *pci_vga_init(PCIBus *bus);

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 03495e1e60..23e5c307a4 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -125,7 +125,7 @@ static void clipper_init(MachineState *machine)

      /* Network setup.  e1000 is good enough, failing Tulip support.  */
      for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
+        pci_nic_init_default(&nd_table[i], pci_bus, mc->default_nic, NULL);
      }

      /* Super I/O */
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 792371fdce..a59e74a81d 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -638,13 +638,7 @@ static void create_pcie(SBSAMachineState *sms)
      pci = PCI_HOST_BRIDGE(dev);
      if (pci->bus) {
          for (i = 0; i < nb_nics; i++) {
-            NICInfo *nd = &nd_table[i];
-
-            if (!nd->model) {
-                nd->model = g_strdup("e1000e");
-            }
-
-            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
+            pci_nic_init_default(nd, pci->bus, "e1000e", NULL);
          }
      }

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9b9f7d9c68..6418bd2fa9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1477,13 +1477,7 @@ static void create_pcie(VirtMachineState *vms)
      vms->bus = pci->bus;
      if (vms->bus) {
          for (i = 0; i < nb_nics; i++) {
-            NICInfo *nd = &nd_table[i];
-
-            if (!nd->model) {
-                nd->model = g_strdup(mc->default_nic);
-            }
-
-            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
+            pci_nic_init_default(&nd_table[i], pci->bus, 
mc->default_nic, NULL);
          }
      }

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index b00a91ecfe..e6316d76d1 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -273,7 +273,7 @@ static void machine_hppa_init(MachineState *machine)

      for (i = 0; i < nb_nics; i++) {
          if (!enable_lasi_lan()) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, 
NULL);
+            pci_nic_init_default(&nd_table[i], pci_bus, 
mc->default_nic, NULL);
          }
      }

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb62c994fa..59ad1ef9f9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1370,12 +1370,10 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus 
*isa_bus, PCIBus *pci_bus)
      rom_set_order_override(FW_CFG_ORDER_OVERRIDE_NIC);
      for (i = 0; i < nb_nics; i++) {
          NICInfo *nd = &nd_table[i];
-        const char *model = nd->model ? nd->model : mc->default_nic;
-
-        if (g_str_equal(model, "ne2k_isa")) {
+        if (nd->model && g_str_equal(nd->model, "ne2k_isa")) {
              pc_init_ne2k_isa(isa_bus, nd);
          } else {
-            pci_nic_init_nofail(nd, pci_bus, model, NULL);
+            pci_nic_init_default(nd, pci_bus, mc->default_nic, NULL);
          }
      }
      rom_reset_order_override();
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index ceddec1b23..1c6824921b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -526,13 +526,7 @@ static void loongarch_devices_init(DeviceState 
*pch_pic, LoongArchMachineState *

      /* Network init */
      for (i = 0; i < nb_nics; i++) {
-        NICInfo *nd = &nd_table[i];
-
-        if (!nd->model) {
-            nd->model = g_strdup(mc->default_nic);
-        }
-
-        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
+        pci_nic_init_default(&nd_table[i], pci_bus, mc->default_nic, NULL);
      }

      /*
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 216812f660..8fef3fc49c 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -454,13 +454,7 @@ static inline void 
loongson3_virt_devices_init(MachineState *machine,
      }

      for (i = 0; i < nb_nics; i++) {
-        NICInfo *nd = &nd_table[i];
-
-        if (!nd->model) {
-            nd->model = g_strdup(mc->default_nic);
-        }
-
-        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
+        pci_nic_init_default(&nd_table[i], pci_bus, mc->default_nic, NULL);
      }
  }

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1cc7c89036..e5a2aaee87 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1867,6 +1867,7 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus 
*rootbus,
      unsigned slot;

      if (nd->model && !strcmp(nd->model, "virtio")) {
+        // DEPRECATE
          g_free(nd->model);
          nd->model = g_strdup("virtio-net-pci");
      }
@@ -1923,6 +1924,19 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, 
PCIBus *rootbus,
      return pci_dev;
  }

+PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
+                               const char *default_model,
+                               const char *default_devaddr);
+PCIDevice *pci_nic_init_default(NICInfo *nd, PCIBus *rootbus,
+                               const char *default_model,
+                               const char *default_devaddr)
+{
+    if (!nd->model) {
+        nd->model = g_strdup(default_model);
+    }
+    return pci_nic_init_nofail(nd, rootbus, nd->model, default_devaddr);
+}
+
  PCIDevice *pci_vga_init(PCIBus *bus)
  {
      vga_interface_created = true;
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index b6eb599751..a53420506b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1074,7 +1074,7 @@ void ppce500_init(MachineState *machine)
      if (pci_bus) {
          /* Register network interfaces. */
          for (i = 0; i < nb_nics; i++) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, 
NULL);
+            pci_nic_init_default(&nd_table[i], pci_bus, 
mc->default_nic, NULL);
          }
      }

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 535710314a..7c86e51997 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -445,7 +445,7 @@ static void ppc_core99_init(MachineState *machine)
      }

      for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
+        pci_nic_init_default(&nd_table[i], pci_bus, mc->default_nic, NULL);
      }

      /* The NewWorld NVRAM is not located in the MacIO device */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 510ff0eaaf..8d42e14909 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -277,7 +277,7 @@ static void ppc_heathrow_init(MachineState *machine)
      pci_vga_init(pci_bus);

      for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
+        pci_nic_init_default(&nd_table[i], pci_bus, mc->default_nic, NULL);
      }

      /* MacIO IDE */
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index f969fa3c29..d58a8952f6 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -247,7 +247,7 @@ static void bamboo_init(MachineState *machine)
               * There are no PCI NICs on the Bamboo board, but there are
               * PCI slots, so we can pick whatever default model we want.
               */
-            pci_nic_init_nofail(&nd_table[i], pcibus, mc->default_nic, 
NULL);
+            pci_nic_init_default(&nd_table[i], pcibus, mc->default_nic, 
NULL);
          }
      }

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 4610abddbd..e50b3b6230 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -324,8 +324,8 @@ static void ibm_40p_init(MachineState *machine)
          pci_vga_init(pci_bus);

          for (i = 0; i < nb_nics; i++) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic,
-                                i == 0 ? "3" : NULL);
+            pci_nic_init_default(&nd_table[i], pci_bus, mc->default_nic,
+                                 i == 0 ? "3" : NULL);
          }
      }

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 4944994e9c..0b82dc0032 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -309,9 +309,10 @@ static void r2d_init(MachineState *machine)
                            0x555, 0x2aa, 0);

      /* NIC: rtl8139 on-board, and 2 slots. */
-    for (i = 0; i < nb_nics; i++)
-        pci_nic_init_nofail(&nd_table[i], pci_bus,
-                            mc->default_nic, i == 0 ? "2" : NULL);
+    for (i = 0; i < nb_nics; i++) {
+        pci_nic_init_default(&nd_table[i], pci_bus,
+                             mc->default_nic, i == 0 ? "2" : NULL);
+    }

      /* USB keyboard */
      usb_create_simple(usb_bus_find(-1), "usb-kbd");
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index b87f842e74..39e63b57cf 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -103,13 +103,7 @@ static void create_pcie(MachineState *ms, 
CPUXtensaState *env, int irq_base,
      pci = PCI_HOST_BRIDGE(dev);
      if (pci->bus) {
          for (i = 0; i < nb_nics; i++) {
-            NICInfo *nd = &nd_table[i];
-
-            if (!nd->model) {
-                nd->model = g_strdup(mc->default_nic);
-            }
-
-            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
+            pci_nic_init_default(&nd_table[i], pci->bus, 
mc->default_nic, NULL);
          }
      }
  }
---

