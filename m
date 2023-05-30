Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB6F715CD6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xKw-00031r-6C; Tue, 30 May 2023 07:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xKu-00031i-8R
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:16:20 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xKs-0003Ai-Jz
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:16:20 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MgwBv-1qZQ824BVF-00hQM2; Tue, 30 May 2023 13:16:16 +0200
Message-ID: <bbf4cddb-053a-7bbb-f62c-f28fc8e01355@vivier.eu>
Date: Tue, 30 May 2023 13:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 03/30] q800: rename q800_init() to q800_machine_init()
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-4-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aSgS43pqlTCLbrsq59/ZUEl3hWaOGNZAq8fUOa/SLVwnW7KlYdX
 knG5+9k25Sp3mZVyvSTJWrfDebLk1pNzEl1SXHug9prB114KvFse5ZSHb5oglDhFlFopMXD
 YT5Q92jr975enxxdAzvqqowLzbbsrJdpI2AtSdAB9kfa68AzYNnL3DPajNf4q/LOcDMUPHw
 CxfuWxc9G1HCRBnIk89Ag==
UI-OutboundReport: notjunk:1;M01:P0:IPhWhYhBAi0=;GDDMYzX04Wfu4CtH/TBIdehnaD6
 kCm9BWmYsysrbq+JFfp8TOGu2/6I/pC1wM9xZ/QZCckpS2YJFUFHLlQIc9vHB0Is5VH/3M52R
 GjWk2bG4Y/XjMqaXvHhAmVWLyhnjd65BPIQ0YOF0YZ9UvxIlpaFr7pc4hqHnNg+xztqt6Nz1V
 VVp0cNSJzOKesUQ5EMjjoPuHHxz/VpfadT/cerctvVhVxujNBHJUJd3b/m9Sj/ZM9s7SLS4WO
 xVPaQJZGw0+sYaLacS5s0zOMTIanW5Mu7suMfsnVctgEm6ePxw81A47THCMebIHshKEeygtHu
 d+w6bC5CeBLcDkg8GbtDOQ5E5yTHjbf4cSunl4mZWJsilVJWVpxy95XkTs/W422u6RUFWP3W0
 6Q8v79TfwnzTYsfpTLItDJ0kKi/he0Vqx4lxBOyhGgk2ML7lSbfhpenu+uDDdqfg6cO/zhQEb
 7swG5DfpoXtUqYGod+GHzoqTOStdKeW2/dJ9vx3H1nmjyAE3V4upG1PhHmNrSXtf552bUFnZv
 gyMdSg+8aOHZf17TbBy+LMEhiSJI7wD7yiKuCm+Gj1sanZWBL7NOayVEg6zYwQZLgMVLMo62b
 xv1pH1Gk1AYRgEN7+S25MZf2dzpqqO54Jy43sWSDhahh7WeW0jvybQy0gTGcsooIaUuu1OvZT
 D4De5NFWVkZac+4skLwy9aKJcxxVhyVxk1+Hdizb+A==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 24/05/2023 à 23:10, Mark Cave-Ayland a écrit :
> This will enable us later to distinguish between QOM initialisation and machine
> initialisation.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index bdccd93c7f..976da06231 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -361,7 +361,7 @@ static uint8_t fake_mac_rom[] = {
>       0x60, 0xFE                          /* bras [self] */
>   };
>   
> -static void q800_init(MachineState *machine)
> +static void q800_machine_init(MachineState *machine)
>   {
>       M68kCPU *cpu = NULL;
>       int linux_boot;
> @@ -737,8 +737,9 @@ static const size_t hw_compat_q800_len = G_N_ELEMENTS(hw_compat_q800);
>   static void q800_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> +
>       mc->desc = "Macintosh Quadra 800";
> -    mc->init = q800_init;
> +    mc->init = q800_machine_init;
>       mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
>       mc->max_cpus = 1;
>       mc->block_default_type = IF_SCSI;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


