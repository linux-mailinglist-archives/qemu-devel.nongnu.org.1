Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01784A1993D
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Jan 2025 20:40:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tagZR-0007CH-AO; Wed, 22 Jan 2025 14:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tagZP-0007C4-5F
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 14:39:23 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tagZM-0005hq-RL
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 14:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=3gdzv8CTcK8HFH9r1fMrzKDsKFqaJjwNwJzXXfWiLT0=; b=B2QwhOXxzamunur2u9JL75IkcX
 aFjg8aI/sV2y6DG2731GcefW3oHVb+NCw9tL5mOaqagqfMOw+EjGj68sO+NTDibOn5eIA/7O6nmCt
 c79GSHqHnm1agceuW8fwurmTcnDCnz5zvbBEC1mWvgZoX/nEXMfBBm00ave4WezVIRdbl4GJCcF8O
 LY2CCkhHibN3kQmtkEfSHuCqmNTO7vP3HqlrNmRRJ13cjuLBb6DgaqboIIiJ6oG7rW0R1GiEakbKm
 IEUfWw85wTGmR87R/biPDjRbKHievFXO35xc6CQWnioWRduL9Vr6Fc/T/4GKiIaN+7p7eCerB4wEt
 uqHOh7bJxXE+vdjVTTZOmticjTXXYdwIu8nzmCKmxlfu5JACJruuGsPR9V8ZIPJhSP+IauHIpQO+n
 qRJD+afKcHw9wmttXPWJYSFN9nwfK2BEWvLo310OEeNnole7/ig3CdMk+1exjQakAfKZ51YNsdwvr
 Vvl+pmPX5FXX4fVxoRCjgBk7eSL0STfn33lNISd6/NvJULNrdzAhNMNn9bcSBF9bceGYqITVLcyTq
 KPC9ruO48OHaiDOlaFzXO/8Kn8T/WQqglidtgNDfAwp6yR1tDbdISw9QUDAmkZ7vOdRcupkWpF/3e
 ZDzNSq3pvwW0OUeAtjTQ6+n4Pw2IpwN9fDEZYwvnQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v4 1/3] coreaudio: Commit the result of init in the end
Date: Wed, 22 Jan 2025 20:39:16 +0100
Message-ID: <9051303.XvfkQlcCyT@silver>
In-Reply-To: <20250117-coreaudio-v4-1-f8d4fa4cb5f4@daynix.com>
References: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
 <20250117-coreaudio-v4-1-f8d4fa4cb5f4@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, January 17, 2025 7:47:00 AM CET Akihiko Odaki wrote:
> init_out_device may only commit some part of the result and leave the
> state inconsistent when it encounters a fatal error or the device gets
> unplugged during the operation, which is expressed by
> kAudioHardwareBadObjectError or kAudioHardwareBadDeviceError. Commit the
> result in the end of the function so that it commits the result iff it
> sees no fatal error and the device remains plugged.
> 
> With this change, handle_voice_change can rely on core->outputDeviceID
> to know whether the output device is initialized after calling
> init_out_device.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  audio/coreaudio.m | 49 +++++++++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index cadd729d5053..b9e1a952ed37 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -355,7 +355,10 @@ static OSStatus audioDeviceIOProc(
>  static OSStatus init_out_device(coreaudioVoiceOut *core)
>  {
>      OSStatus status;
> +    AudioDeviceID deviceID;
>      AudioValueRange frameRange;
> +    UInt32 audioDevicePropertyBufferFrameSize;
> +    AudioDeviceIOProcID ioprocid;

So you said 'outDeviceID' was 'too verbose', ... but
'audioDevicePropertyBufferFrameSize' is not? :-)

/Christian

>      AudioStreamBasicDescription streamBasicDescription = {
>          .mBitsPerChannel = core->hw.info.bits,
> @@ -368,20 +371,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>          .mSampleRate = core->hw.info.freq
>      };
>  
> -    status = coreaudio_get_voice(&core->outputDeviceID);
> +    status = coreaudio_get_voice(&deviceID);
>      if (status != kAudioHardwareNoError) {
>          coreaudio_playback_logerr (status,
>                                     "Could not get default output Device\n");
>          return status;
>      }
> -    if (core->outputDeviceID == kAudioDeviceUnknown) {
> +    if (deviceID == kAudioDeviceUnknown) {
>          dolog ("Could not initialize playback - Unknown Audiodevice\n");
>          return status;
>      }
>  
>      /* get minimum and maximum buffer frame sizes */
> -    status = coreaudio_get_framesizerange(core->outputDeviceID,
> -                                          &frameRange);
> +    status = coreaudio_get_framesizerange(deviceID, &frameRange);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -392,31 +394,31 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>      }
>  
>      if (frameRange.mMinimum > core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
>          dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
>      } else if (frameRange.mMaximum < core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
>          dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
>      } else {
> -        core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
> +        audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
>      }
>  
>      /* set Buffer Frame Size */
> -    status = coreaudio_set_framesize(core->outputDeviceID,
> -                                     &core->audioDevicePropertyBufferFrameSize);
> +    status = coreaudio_set_framesize(deviceID,
> +                                     &audioDevicePropertyBufferFrameSize);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>      }
>      if (status != kAudioHardwareNoError) {
>          coreaudio_playback_logerr (status,
>                                      "Could not set device buffer frame size %" PRIu32 "\n",
> -                                    (uint32_t)core->audioDevicePropertyBufferFrameSize);
> +                                    (uint32_t)audioDevicePropertyBufferFrameSize);
>          return status;
>      }
>  
>      /* get Buffer Frame Size */
> -    status = coreaudio_get_framesize(core->outputDeviceID,
> -                                     &core->audioDevicePropertyBufferFrameSize);
> +    status = coreaudio_get_framesize(deviceID,
> +                                     &audioDevicePropertyBufferFrameSize);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -425,11 +427,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>                                      "Could not get device buffer frame size\n");
>          return status;
>      }
> -    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
>  
>      /* set Samplerate */
> -    status = coreaudio_set_streamformat(core->outputDeviceID,
> -                                        &streamBasicDescription);
> +    status = coreaudio_set_streamformat(deviceID, &streamBasicDescription);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -437,7 +437,6 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>          coreaudio_playback_logerr (status,
>                                     "Could not set samplerate %lf\n",
>                                     streamBasicDescription.mSampleRate);
> -        core->outputDeviceID = kAudioDeviceUnknown;
>          return status;
>      }
>  
> @@ -451,20 +450,24 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>       * Therefore, the specified callback must be designed to avoid a deadlock
>       * with the callers of AudioObjectGetPropertyData.
>       */
> -    core->ioprocid = NULL;
> -    status = AudioDeviceCreateIOProcID(core->outputDeviceID,
> +    ioprocid = NULL;
> +    status = AudioDeviceCreateIOProcID(deviceID,
>                                         audioDeviceIOProc,
>                                         &core->hw,
> -                                       &core->ioprocid);
> +                                       &ioprocid);
>      if (status == kAudioHardwareBadDeviceError) {
>          return 0;
>      }
> -    if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
> +    if (status != kAudioHardwareNoError || ioprocid == NULL) {
>          coreaudio_playback_logerr (status, "Could not set IOProc\n");
> -        core->outputDeviceID = kAudioDeviceUnknown;
>          return status;
>      }
>  
> +    core->outputDeviceID = deviceID;
> +    core->audioDevicePropertyBufferFrameSize = audioDevicePropertyBufferFrameSize;
> +    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
> +    core->ioprocid = ioprocid;
> +
>      return 0;
>  }
>  
> @@ -548,7 +551,9 @@ static OSStatus handle_voice_change(
>          fini_out_device(core);
>      }
>  
> -    if (!init_out_device(core)) {
> +    init_out_device(core);
> +
> +    if (core->outputDeviceID) {
>          update_device_playback_state(core);
>      }



